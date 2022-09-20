<?php
namespace app\controllers;

use core\App;
use core\Utils;
use core\RoleUtils;
use core\ParamUtils;
use core\Validator;
use core\SessionUtils;
use app\forms\ProductAddForm;


class AddingNewProductCtrl
{
private $form;
public function __construct()
{
    $this->form = new ProductAddForm();
}

public function validate()
{
        $this->form->name = ParamUtils::getFromRequest('name');
        $this->form->description = ParamUtils::getFromRequest('description');
        $this->form->price = ParamUtils::getFromRequest('price');
        $this->form->category = ParamUtils::getFromRequest('category');
        if (!(isset($this->form->name) && isset($this->form->description) && isset($this->form->price) && isset($this->form->category))) {
        return false;
    }
   
        if (empty($this->form->name)) {
            Utils::addErrorMessage('Nie podano nazwy produktu');
        }
        if (empty($this->form->description)) {
            Utils::addErrorMessage('Nie podano opisu produktu');
        }
        if (empty($this->form->price)) {
            Utils::addErrorMessage('Nie wpisano ceny produktu');
        }
        if (empty($this->form->category)) {
            Utils::addErrorMessage('Nie wybrano kategorii produktu');
        }
    
        if (App::getMessages()->isError())
        return false;

    try {
        $product = App::getDB()->get("product", '*', [
            "name" => $this->form->name
        ]);
    } catch (\PDOException $e) {
        Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordu!');
        if (App::getConf()->debug)
            Utils::addErrorMessage($e->getMessage());
    }
    
    if ($product != 0) {
        Utils::addErrorMessage('Obiekt o podanej nazwie już istnieje!');
        $product = 0;
    }
    return !App::getMessages()->isError();
}

public function validateData(){
    $v = new Validator();

    $this->form->name = $v->validateFromPost('name', [
        'trim' => true,
        'required' => true,
        'required_message' => 'Podaj nazwe produktu',
        'min_length' => 5,
        'max_length' => 25,
        'validator_message' => 'Tytuł powinnien mieć od 5 do 25 znaków'
    ]);
	
    $this->form->category = $v->validateFromPost('category', [
        'trim' => true,
        'required' => true,
        'required_message' => 'Podaj kategorie produktu',
        'min_length' => 3,
        'max_length' => 25,
        'validator_message' => 'Nazwa wydawnictwa powinna mieć od 3 do 25 znaków'
    ]);
    
    $this->form->description = $v->validateFromPost('description', [
        'trim' => true,
        'required' => true,
        'required_message' => 'Podaj opis produktu',
        'min_length' => 3,
        'max_length' => 25,
        'validator_message' => 'Pole powinno zawierać od 3 do 16 znaków'
    ]);


    return !App::getMessages()->isError();
}
    
public function addNewProduct() {
    if($this->validateData()){
    App::getDB()->insert("product", [
        "name" => $this->form->name,
        "description" => $this->form->description,
        "price" => $this->form->price,
        "category" => $this->form->category
    ]);
    }else{
        $this->generateView();
    }
}



public function action_addAdminProduct(){
    if($this->validate()){
        $this->addNewProduct();
        Utils::addErrorMessage('Poprawnie dodano');
        App::getRouter()->redirectTo("shopShow");
    } else {
        $this->generateView();
    }
    }

public function generateView(){
    App::getSmarty()->assign('user', SessionUtils::loadObject("user", true));
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->display('ProductAddNew.tpl');
}
}