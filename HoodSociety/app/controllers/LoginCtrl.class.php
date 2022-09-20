<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\RoleUtils;
use core\ParamUtils;
use core\SessionUtils;
use app\forms\LoginForm;

class LoginCtrl {

    private $l_form; //formularz logowania
    private $users;
    private $login;

    public function __construct() {
        //stworzenie potrzebnych obiektów
        $this->l_form = new LoginForm();
    }

    public function validate() {
        $this->l_form->login = ParamUtils::getFromRequest('login');
        $this->l_form->pass = ParamUtils::getFromRequest('pass');
        //nie ma sensu walidować dalej, gdy brak parametrów
        if (!isset($this->l_form->login))
            return false;
        
        // sprawdzenie, czy potrzebne wartości zostały przekazane
        if (empty($this->l_form->login)) {
            Utils::addErrorMessage('Nie podano loginu');
        }
        if (empty($this->l_form->pass)) {
            Utils::addErrorMessage('Nie podano hasła');
        }
        
        //nie ma sensu walidować dalej, gdy brak wartości
        if (App::getMessages()->isError())
            return false;
    
        // sprawdzenie, czy dane logowania poprawne
        // (takie informacje najczęściej przechowuje się w bazie danych)
        
        $search_params = [];
        $search_params ['login'] = $this->l_form->login;
        $where = &$search_params;
        
        try {
            $this->users = App::getDB()->select("user", [
                "login",
                "pass",
                "role",
                    ], $where);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }
        
        if (count($this->users) == 0) {
            Utils::addErrorMessage('Użytkownik nie istnieje!');
        }
        
        if (App::getMessages()->isError())
            return false;
        
        foreach ($this->users as $u){
            if ($this->l_form->pass == $u["pass"]) {
            RoleUtils::addRole($u["role"]);
            SessionUtils::store($log, $this->l_form->login);
            setcookie("log", $this->l_form->login, time() + (3600), "/");
            break;
        }else{
            Utils::addErrorMessage('Niepoprawny login lub hasło');
             }
        }

        return !App::getMessages()->isError();
    }

    public function action_loginShow() {
        $this->generateView();
    }

    public function action_login() {
        if ($this->validate()) {
            //zalogowany => przekieruj na główną akcję (z przekazaniem messages przez sesję)
            Utils::addErrorMessage('Poprawnie zalogowano do systemu');
            App::getRouter()->redirectTo("shopShow");
        } else {
            //niezalogowany => pozostań na stronie logowania
            App::getSmarty()->assign('log', '');
            $this->generateView();
        }
    }

    public function action_logout() {
        // 1. zakończenie sesji
        setcookie("log", "", time() - 3600);
        session_destroy();
        // 2. idź na stronę główną - system automatycznie przekieruje do strony logowania
        App::getRouter()->redirectTo('shopShow');
    }

    public function generateView() {
        App::getSmarty()->assign('log', '');
        App::getSmarty()->assign('l_form', $this->l_form); // dane formularza do widoku
        App::getSmarty()->display('loginView.tpl');
    }

}
?>