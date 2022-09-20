<!DOCTYPE HTML>
<!--
        Editorial by HTML5 UP
        html5up.net | @ajlkn
        Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
    <head>
        <title>Hood Society</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
        <link rel="stylesheet" href="{$conf->app_url}/assets/css/main.css" />
        <link rel="stylesheet" href="{$conf->app_url}/assets/css/fontawesome.css" />
        <link rel="stylesheet" href="{$conf->app_url}/assets/css/solid.css" />
    </head>
    <body class="is-preload">

        <!-- Wrapper -->
        <div id="wrapper">

            <!-- Main -->
            <div id="main">
                <div class="inner">

                    <!-- Header -->
                    <header id="header">
                        <div class="row">
                            <div class="col-2 col-12-small">
                                <a href="{$conf->action_root}shopShow" class="logo"><strong>HoodSociety</strong></a>
                            </div>
                            <div class="col-4 col-12-small">
                                <section id="search" class="alt">
                                    <form method="post" id="search-form" action="{$conf->action_root}search">
                                        <input type="text" name="sf_query" placeholder="Wpisz zapytanie..." value="{$searchForm->query|default}"/>
                                    </form>
                                    <style>
                                        #search-form{
                                            border: 2px solid #43de52;
                                            border-radius: 8px;
                                        }
                                    </style>
                                </section>
                            </div>
                            <div class="col-4 col-12-small" align="center">
                                {if count($conf->roles)>0}
                                    <p>Użytkownik:<br><em style="color:darkgreen;">{\core\SessionUtils::load($log, true)|default}</em></p>
                                {else}
                                {/if}
                            </div>
                            <div class="col-2 col-12-small" align="right">
                                <ul class="actions">
                                    <li>
                                        {if count($conf->roles)>0}
                                            <a href="{$conf->action_root}logout" class="button primary icon solid fa-sign-out-alt" onclick="info()">Wyloguj</a>
                                        {else}	
                                            <a href="{$conf->action_root}loginShow" class="button icon solid fa-sign-in-alt">Logowanie</a>
                                        {/if}
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </header>

                {block name=content}{/block}
                
                {block name=messages}

                    {if $msgs->isMessage()}
                        <div class="messages bottom-margin">
                            <ul>
                                {foreach $msgs->getMessages() as $msg}
                                    {strip}
                                        <li class="msg {if $msg->isError()}error{/if} {if $msg->isWarning()}warning{/if} {if $msg->isInfo()}info{/if}">{$msg->text}</li>
                                        {/strip}
                                    {/foreach}
                            </ul>
                        </div>
                    {/if}

                {/block}

            </div>
        </div>

        <!-- Sidebar -->
        <div id="sidebar">
            <div class="inner">

                <!-- Menu -->
                <nav id="menu">
                    <header class="major">
                        <h2>Menu</h2>
                    </header>
                    <ul>
                        <li><a href="{$conf->action_root}shopShow" class="icon solid fa-home"> Strona główna</a></li>
                        <li>
                            <span class="opener">Koszulki</span>
                            <ul>
                                <li><a href="{$conf->action_root}search/koszulki">Koszulki</a></li>
                                <li><a href="{$conf->action_root}search/koszulki-longsleeve">koszulki longsleeve</a></li>
                            </ul>
                        </li>
                        <li>
                            <span class="opener">Bluzy</span>
                            <ul>
                                <li><a href="{$conf->action_root}search/bluzy">Bluzy</a></li>
                                <li><a href="{$conf->action_root}search/bluzy-sweatshirt">Bluzy sweatshirt</a></li>
                            </ul>
                        </li>
                        <li>
                            <span class="opener">Bezrekawniki</span>
                            <ul>
                                <li><a href="{$conf->action_root}search/bezrekawniki">Bezrekawniki</a></li>
                            </ul>
                        </li>
                        <li>
                            <span class="opener">Spodnie i dodatki</span>
                            <ul>
                                <li><a href="{$conf->action_root}search/spodnie">Spodnie</a></li>
                                <li><a href="{$conf->action_root}search/czapki">Czapki</a></li>
                            </ul>
                        </li>
                        <li>
                            {if count($conf->roles)>0}
								<a href="{$conf->action_root}orderNew" class="pure-menu-heading pure-menu-link icon solid fa-cash-register" ></i> Realizuj zamówienie</a>
							    <a href="{$conf->action_root}addingNew" class="pure-menu-heading pure-menu-link icon solid fa-plus"> Dodaj produkt (Admin only)</a>
                                <a href="{$conf->action_root}cartShow" class="pure-menu-heading pure-menu-link icon solid fa-shopping-cart"> Koszyk ({number_format($cartValue, 2, ',', ' ')} zł)</a>
                                <a href="{$conf->action_root}accountShow" class="pure-menu-heading pure-menu-link icon solid fa-user"> Konto ({\core\SessionUtils::load($log, true)|default})</a>
                                <a href="{$conf->action_root}logout" class="pure-menu-heading pure-menu-link icon solid fa-sign-out-alt" onclick="info()"> Wyloguj</a>
                            {else}	
                                <a href="{$conf->action_root}loginShow" class="pure-menu-heading pure-menu-link icon solid fa-sign-in-alt"> Logowanie</a>
                            {/if}
                        </li>
                    </ul>
                </nav>
                <script>
                    function info(){
                        alert("Poprawnie wylogowano.");
                    }
                </script>
                <!-- Section -->
                <section>
                    <header class="major">
                        <h2>Dlaczego warto u nas kupować:</h2>
                    </header>
                    <div class="mini-posts">
                        <article>
                            <a class="image"><img src="{$conf->app_url}/images/spec-of.jpg" alt="" /></a>
                            <p>Liczne promocje, rabaty dla stałych klientów i sezonowe wyprzedaże.</p>
                        </article>
                        <article>
                            <a class="image"><img src="{$conf->app_url}/images/gwarancja.jpg" alt="" /></a>
                            <p>Gwarancja najwyższej jakości oferowanych przez nas produktów.</p>
                        </article>
                        <article>
                            <a class="image"><img src="{$conf->app_url}/images/gratis.jpg" alt="" /></a>
                            <p>Szybka i darmowa dostawa dla zamówień powyżej 300zł.</p>
                        </article>
                    </div>
                </section>

                <!-- Section -->
                <section>
                    <header class="major">
                        <h2>Kontakt</h2>
                    </header>
                    <ul class="contact">
                        <li class="icon solid fa-envelope">kontakt.hoodsociety@gmail.com</li>
                        <li class="icon solid fa-phone">+48 332 112 322</li>
                        <li class="icon solid fa-home">W razie kontaktu stacjonarnego znajdziesz nas:<br />
                            Korfantego 31<br />
                            40-004 Katowice<br />
                            Polska<br /><br />
                            <a href="https://www.google.pl/maps/place/Korfantego+31,_40-004+Katowice" target="_blank">Pokaż na mapie</a></li>
                        <li class="icon solid fa-clock"> Godziny otwarcia sklepu stacjonarnego:<br />
                            pon-pt: 08:00 - 16:00<br />
                            sobota: 09:00 - 12:00<br />
                            niedziela: nieczynne</li>
                    </ul>
                </section>

                <!-- Footer -->
                <footer id="footer">
                    <p class="copyright">&copy; Untitled. All rights reserved. Demo Images: <a href="https://unsplash.com">Unsplash</a>. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
                </footer>

            </div>
        </div>
    </div>


    <!-- Scripts -->
    <script src="{$conf->app_url}/assets/js/jquery.min.js"></script>
    <script src="{$conf->app_url}/assets/js/browser.min.js"></script>
    <script src="{$conf->app_url}/assets/js/breakpoints.min.js"></script>
    <script src="{$conf->app_url}/assets/js/util.js"></script>
    <script src="{$conf->app_url}/assets/js/main.js"></script>
    <script src="{$conf->app_url}/assets/js/functions.js"></script>

</body>
</html>