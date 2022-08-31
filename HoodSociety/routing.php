<?php

use core\App;
use core\Utils;

App::getRouter()->setDefaultRoute('shopShow');                                  //akcja domyślna
App::getRouter()->setLoginRoute('login');                                       //przekieruj, jeśli brak uprawnień


?>