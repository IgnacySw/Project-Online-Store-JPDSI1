<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\RoleUtils;
use core\ParamUtils;
use core\Validator;
use app\forms\RegisterForm;

class RegisterCtrl {

    private $r_form;

    public function __construct() {
        $this->r_form = new RegisterForm();
    }

    public function validate() {
        $this->r_form->login1 = ParamUtils::getFromRequest('login1');
        $this->r_form->pass1 = ParamUtils::getFromRequest('pass1');
        $this->r_form->pass2 = ParamUtils::getFromRequest('pass2');

        if (!isset($this->r_form->login1))
            return false;

        if (empty($this->r_form->login1)) {
            Utils::addErrorMessage('Nie podano loginu');
        }
        if (empty($this->r_form->pass1)) {
            Utils::addErrorMessage('Nie podano hasła');
        }
        if (empty($this->r_form->pass2)) {
            Utils::addErrorMessage('Nie podano hasła ponownie');
        }
        if(($this->r_form->pass1) != ($this->r_form->pass2)){
            Utils::addErrorMessage('Hasła nie są zgodne!');
        }

        if (App::getMessages()->isError())
            return false;

        try {
            $user = App::getDB()->get("user", '*', [
                "login" => $this->r_form->login1
            ]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordu!');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }
        
        if ($user != 0) {
            Utils::addErrorMessage('Użytkownik o poddanym loginie już istnieje!');
            $user = 0;
        }
        return !App::getMessages()->isError();
    }
    
    public function validateData(){
        $v = new Validator();

        $this->r_form->login1 = $v->validateFromPost('login1', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Podaj login',
            'min_length' => 3,
            'max_length' => 25,
            'validator_message' => 'Login powinien mieć od 3 do 25 znaków'
        ]);
        
        $this->r_form->pass1 = $v->validateFromPost('pass1', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Podaj hasło',
            'min_length' => 5,
            'max_length' => 25,
            'validator_message' => 'Hasło powinno mieć od 5 do 25 znaków'
        ]);
        
        return !App::getMessages()->isError();
    }
    
    public function addNewUser() {
        if($this->validateData()){
        App::getDB()->insert("user", [
            "login" => $this->r_form->login1,
            "pass" => $this->r_form->pass1,
            "role" => "user",
        ]);
        }else{
            $this->generateView();
        }
    }
    
    public function action_registerShow() {
        $this->generateView();
    }
    
    public function action_register() {
        if($this->validate()){
            $this->addNewUser();
            Utils::addErrorMessage('Poprawnie zarejestrowano');
            App::getRouter()->redirectTo("loginShow");
        } else {
            $this->generateView();
        }
    }
    
    public function generateView() {
        App::getSmarty()->assign('r_form', $this->r_form);
        App::getSmarty()->display('registerView.tpl');
    }

}
