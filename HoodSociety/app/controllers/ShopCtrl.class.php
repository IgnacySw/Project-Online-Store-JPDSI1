<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\SessionUtils;
use app\forms\ProductSearchForm;
use app\forms\AddressForm;
use app\transfer\Pages;

class ShopCtrl {

    private $ps_form;
    private $records;
    private $cart_items;
    private $address_form;
    private $pages;

    public function __construct() {
        $this->ps_form = new ProductSearchForm();
        $this->address_form = new AddressForm();
        $this->pages = new Pages();
    }

    public function validate() {//walidacja danych
        if (ParamUtils::getFromRequest('sf_query') != NULL) {
            $this->ps_form->query = ParamUtils::getFromRequest('sf_query');
        } else {
            $this->ps_form->query = ParamUtils::getFromCleanURL(1, false, 'Błędne wywołanie aplikacji');
        }
        return !App::getMessages()->isError();
    }

    public function load_data() {
        $this->validate();

        if (is_numeric(ParamUtils::getFromCleanURL(1, false, 'Błędne wywołanie aplikacji'))) {
            $this->pages->currentPage = intval(ParamUtils::getFromCleanURL(1, false, 'Błędne wywołanie aplikacji'));
        } else {
            $this->pages->currentPage = 1;
        }

        $search_params = [];            //okreslenie parametrow wyszukiwania
        if (isset($this->ps_form->query) && strlen($this->ps_form->query) > 0) {//zobaczyc te query
            $search_params['name[~]'] = '%' . $this->ps_form->query . '%';
            $search_params['category[~]'] = $this->ps_form->query . '%';
        }

        $num_params = sizeof($search_params); //ilosc parametrow wyszukiwania
        if ($num_params > 1) {                //jesli jest wieksza niz jeden to zastosoj or'a dla wynikow wyszukiwania
            $where = ["OR" => &$search_params];
        } else {                              //jesli nie, to wybierz jedno jako filtr wyszukiwania
            $where = &$search_params;
        }
        
        $limit = 5;//okreslenie limitu

        $this->pages->recNum = App::getDB()->count("product", $where);//zliczanie z bazy liczby parametrow dla productow i przypisanie do rec num
        $this->pages->lastPage = ceil($this->pages->recNum / $limit);//okreslenie ostatniej strony, ktora wyliczona jest z liczby prodoktow/limit
                            //ceil(25.75) oznacza - Return the smallest integer value that is greater than or equal to 25.75:


        if ($this->pages->currentPage > $this->pages->lastPage) {//sprawdzenie czy obecna strona jest wieksza od ostatniej
            $this->pages->currentPage = 1;              //jesli tak to przypisz numer aktualnej strony jako 1wszej
        }


        $from = ($this->pages->currentPage - 1) * $limit;//zobaczyc czy to wybor z ktorej strony

        $where ["ORDER"] = "name";
        $where ["LIMIT"] = [$from, $limit];//zaladowanie wartosci 0 na pierwszy produkt, bo to jest id pierwszego w database
                                           //nastepnie okresla limit dla ilosci na dana strone ktory okreslony jest w $limit

        try {
            $this->records = App::getDB()->select("product", [//zapytanie wyslane do database o produkty i wyswietlenie
                "id_product",
                "category",
                "name",
                "description",
                "price",
                    ], $where);//zliczenie produktow okreslonych limitem i orderem, czyli ze chce wyszukac name w danym przedziale
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($e->getMessage());
            }
        }
    }

    public function addProduct() {      //to opisac
        $this->load_cart();             //zaladowanie carta
        $id_product = ParamUtils::getFromCleanURL(1, true, 'Błędne wywołanie aplikacji');
        $login = $_COOKIE["log"];//login
        if ($this->cart_items != NULL) {
            try {
                $isInCart = App::getDB()->has("cart", [     //sprawdzenie czy w koszyku wystepuje juz dany produkt
                    "id_product" => $id_product,
                    "cart_user" => $login
                ]);

                if ($isInCart) {        //jesli jest produkt to zwieksz jego quantity o 1
                    App::getDB()->update("cart", [
                        "quantity[+]" => 1
                            ], [
                        "id_product" => $id_product
                    ]);
                } else {                //jesli nie ma danego produktu w koszyku to po prostu dodaj go do koszyka
                    $data = App::getDB()->get("product", [
                        "name",
                        "price"
                            ], [
                        "id_product" => $id_product
                    ]);

                    App::getDB()->insert("cart", [      //dodanie do tabeli cart w db danego produktu
                        "name" => $data['name'],
                        "quantity" => 1,
                        "price" => $data['price'],
                        "cart_user" => $login,
                        "status" => "open",
                        "id_product" => $id_product
                    ]);
                }
            } catch (\PDOException $e) {
                Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
                if (App::getConf()->debug) {
                    Utils::addErrorMessage($e->getMessage());
                }
            }
        } else {        //jesli koszyk jest pusty po prostu dodaj produkt, bo i tak nie bedzie takiego samego
            try {
                $data = App::getDB()->get("product", [
                    "name",
                    "price"
                        ], [
                    "id_product" => $id_product
                ]);

                App::getDB()->insert("cart", [      //dodanie do tabeli cart w db danego produktu
                    "name" => $data['name'],
                    "quantity" => 1,
                    "price" => $data['price'],
                    "cart_user" => $login,
                    "status" => "open",
                    "id_product" => $id_product
                ]);
            } catch (\PDOException $e) {
                Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
                if (App::getConf()->debug) {
                    Utils::addErrorMessage($e->getMessage());
                }
            }
        }
    }

    public function deleteProduct() {               //usuwanie produktu z cart'a
        $id_product = ParamUtils::getFromCleanURL(1, true, 'Błędne wywołanie aplikacji');
        try {
            App::getDB()->delete("cart", [          //usuniecie produktu o podanym id z tabeli cart
                "id_product" => $id_product
            ]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($e->getMessage());
            }
        }
    }

    public function load_cart() {    //to tez opisac
        $login = $_COOKIE["log"];           //login
        try {
            $this->cart_items = App::getDB()->select("cart", "*", [     //przypisanie wartosci z tabeli cart do cart_items
                "cart_user" => $login,          //przypisanie cart_usera do $loginu, który brany jest z ciasteczek
                "status" => "open"              //otwarcie statusu cartu
            ]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }
    }

    public function updateCartValue() {         //to opisac bo to wazne
        $zmienna=SessionUtils::load("log",$keep=true);
        $login = $_COOKIE["log"];
        try {
            $prizeQ = App::getDB()->select("cart", [
                "price",
                "quantity",
                    ], [
                "cart_user" => $login,
                "status" => "open"
            ]);
            $cartValue = 0;
            foreach ($prizeQ as $pQ) {
                $cartValue = $cartValue + ($pQ['price'] * $pQ['quantity']);
            }
            if ($cartValue == NULL) {
                $cartValue = 0;
            }
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }
        if(isset($cartValue))App::getSmarty()->assign('cartValue', $cartValue);
        if(isset($cartValue))return $cartValue;
    }

    public function buy() {
        $this->address_form->address = ParamUtils::getFromRequest('address');
        $this->address_form->email = ParamUtils::getFromRequest('email');
        $this->address_form->phone = ParamUtils::getFromRequest('phone');
        if (empty($this->address_form->address)) {
            Utils::addErrorMessage('Nie podano adresu dostawy');
        }
        if (empty($this->address_form->email)) {
            Utils::addErrorMessage('Nie podano adresu email');
        }
        if (empty($this->address_form->phone)) {
            Utils::addErrorMessage('Nie podano numeru telefonu');
        }
        if (App::getMessages()->isError())
            return false;
        
        $date = date("Y-m-d H:i:s");
        $login = $_COOKIE["log"];
        try {
            $id_user = App::getDB()->get("user", "id_user", [
                "login" => $login
            ]);
            App::getDB()->insert("orders", [
                "date" => $date,
                "address" => $this->address_form->address,
                "email" => $this->address_form->email,
                "phone" => $this->address_form->phone,
                "total" => $this->updateCartValue(),
                "id_user" => $id_user
            ]);
            $id_order = App::getDB()->get("orders", "id_order", [
                "date" => $date
            ]);
            App::getDB()->update("cart", [
                "status" => "closed",
                "id_order" => $id_order
                    ], [
                "cart_user" => $login,
                "status" => "open",
                "id_order" => NULL
            ]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($e->getMessage());
            }
        }
        Utils::addErrorMessage('Poprawnie dodano');
        App::getRouter()->redirectTo('shopShow');
    }

    public function addNewProduct() {
        $this->address_form->address = ParamUtils::getFromRequest('address');
        $this->address_form->email = ParamUtils::getFromRequest('email');
        $this->address_form->phone = ParamUtils::getFromRequest('phone');
        if (empty($this->address_form->address)) {
            Utils::addErrorMessage('Nie podano adresu dostawy');
        }
        if (empty($this->address_form->email)) {
            Utils::addErrorMessage('Nie podano adresu email');
        }
        if (empty($this->address_form->phone)) {
            Utils::addErrorMessage('Nie podano numeru telefonu');
        }
        if (App::getMessages()->isError())
            return false;
        
        $date = date("Y-m-d H:i:s");
        $login = $_COOKIE["log"];
        try {
            $id_user = App::getDB()->get("user", "id_user", [
                "login" => $login
            ]);
            App::getDB()->insert("product", [
                "name" => $this->address_form->address,
                "category" => $this->address_form->email,
                "description" => $this->address_form->address,
                "price" => $this->address_form->phone,
                //"id_product" => $this->address_form->id_product
            ]);
            // App::getDB()->insert("orders", [
            //     "date" => $date,
            //     "address" => $this->address_form->address,
            //     "email" => $this->address_form->email,
            //     "phone" => $this->address_form->phone,
            //     "total" => $this->updateCartValue(),
            //     "id_user" => $id_user
            // ]);
            // $id_order = App::getDB()->get("orders", "id_order", [
            //     "date" => $date
            // ]);
            App::getDB()->update("cart", [
                "status" => "closed",
                "id_order" => $id_order
                    ], [
                "cart_user" => $login,
                "status" => "open",
                "id_order" => NULL
            ]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($e->getMessage());
            }
        }
        Utils::addErrorMessage('Poprawnie dodano');
        App::getRouter()->redirectTo('search/bluzy/koszulki');
    }

    // public function addNewProduct() {
    //     $this->address_form->name = ParamUtils::getFromRequest('name');
    //     $this->address_form->category = ParamUtils::getFromRequest('category');
    //     $this->address_form->description = ParamUtils::getFromRequest('description');
    //     $this->address_form->price = ParamUtils::getFromRequest('price');
    //     if (empty($this->address_form->name)) {
    //         Utils::addErrorMessage('Nie podano nazwy nowego produktu');
    //     }
    //     if (empty($this->address_form->category)) {
    //         Utils::addErrorMessage('Nie podano kategorii nowego produktu');
    //     }
    //     if (empty($this->address_form->description)) {
    //         Utils::addErrorMessage('Nie podano opisu nowego produktu');
    //     }
    //     if (empty($this->address_form->price)) {
    //         Utils::addErrorMessage('Nie podano ceny nowego produktu');
    //     }
    //     if (App::getMessages()->isError())
    //         return false;
        
    //     $id_product = ParamUtils::getFromCleanURL(1, true, 'Błędne wywołanie aplikacji');    
    //     $date = date("Y-m-d H:i:s");
    //     $login = $_COOKIE["log"];
    //     try {
    //         $id_user = App::getDB()->get("user", "id_user", [
    //             "login" => $login
    //         ]);
    //         // $id_product = App::getDB()->get("product", "id_product", [
    //         //     "id_product[+]" => 1
    //         // ]);
    //         App::getDB()->insert("product", [
    //             "name" => $this->address_form->name,
    //             "category" => $this->address_form->category,
    //             "description" => $this->address_form->description,
    //             "price" => $this->address_form->price,
    //             "id_product" => $this->address_form->id_product
    //         ]);
    //         App::getDB()->insert("orders", [
    //             "date" => $date,
    //             "address" => $this->address_form->name,
    //             "email" => $this->address_form->description,
    //             "phone" => $this->address_form->price,
    //             "total" => $this->updateCartValue(),
    //             "id_user" => $id_user
    //         ]);

    //         $id_user = App::getDB()->get("user", "id_user", [
    //             "date" => $date
    //         ]);
    //         App::getDB()->update("cart", [
    //             "status" => "closed",
    //             "id_product" => $id_product
    //                 ], [
    //             "cart_user" => $login,
    //             "status" => "open",
    //             "id_product" => NULL
    //         ]);
    //     } catch (\PDOException $e) {
    //         Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
    //         if (App::getConf()->debug) {
    //             Utils::addErrorMessage($e->getMessage());
    //         }
    //     }

    //     App::getRouter()->redirectTo('shopShow');
    // }

    public function action_shopShow() {
        if (isset($_COOKIE["log"])) {
            $this->updateCartValue();
        }
        App::getSmarty()->display('shopView.tpl');
    }

    public function action_search() {
        $this->load_data();
        $this->updateCartValue();
        //App::getSmarty()->assign('q_form', $this->q_form);
        App::getSmarty()->assign('searchForm', $this->ps_form);
        App::getSmarty()->assign('products', $this->records);
        App::getSmarty()->assign('pages', $this->pages);
        App::getSmarty()->display('productListView.tpl');
    }

    public function action_productListTable() {
        $this->load_data();
        $this->updateCartValue();
        //App::getSmarty()->assign('q_form', $this->q_form);
        App::getSmarty()->assign('searchForm', $this->ps_form);
        App::getSmarty()->assign('products', $this->records);
        App::getSmarty()->assign('pages', $this->pages);
        App::getSmarty()->display('productListViewTable.tpl');
    }

    public function action_addToCart() {
        $this->addProduct();
        App::getRouter()->redirectTo('cartShow');
    }

    public function action_cartShow() {
        $this->load_cart();
        $this->updateCartValue();
        App::getSmarty()->assign('total', 0);
        App::getSmarty()->assign('cart', $this->cart_items);
        App::getSmarty()->display('cartView.tpl');
    }

    public function action_productAddNew() {
        if (isset($_COOKIE["log"])) {
            $this->updateCartValue();
        }
        App::getSmarty()->assign('address_form', $this->address_form);
        App::getSmarty()->display('productAddNew.tpl');
    }

    public function action_deleteFromCart() {
        $this->deleteProduct();
        App::getRouter()->redirectTo('cartShow');
    }

    public function action_orderNew() {
        if (isset($_COOKIE["log"])) {
            $this->updateCartValue();
        }
        App::getSmarty()->assign('address_form', $this->address_form);
        App::getSmarty()->display('finalizeView.tpl');
    }

    public function action_addingNew() {
        if (isset($_COOKIE["log"])) {
            $this->updateCartValue();
        }
        App::getSmarty()->assign('address_form', $this->address_form);
        App::getSmarty()->display('productAddNew.tpl');
    }

    public function action_finalizeOrder() {
        $this->buy();
    }

    public function action_finalizeAddNewProduct() {
        $this->addNewProduct();
    }

}

?>