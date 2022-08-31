<?php
require_once 'init.php';
require_once 'routing.php';

//metoda ładująca obiekt Messages z sesji (jeśli został tam zachowany) - pozwala to komunikatom "przetrwać" redirect.
\core\SessionUtils::loadMessages();

//uruchomienie routera
\core\App::getRouter()->go();
?>