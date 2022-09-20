{extends file="main.tpl"}

{block name=content}
    <section id="banner">
        <div class="content">
            <header>
                <h1 id="hood">Hood</h1><h1 id="society">Society</h1>
                <h2>Zapewnij sobie wyjatkowy wystroj garderoby</h2>
                <style>
                    #hood {
                        display: inline;
                        color: #43de52;
                        /*text-shadow: 25px 15px 5px gray;*/
                        line-height: 2;
                    }
                    #society {
                        display: inline;
                        color: darkgreen;
                        /*text-shadow: 25px 15px 5px #43de52;*/
                        line-height: 2;
                    }
                </style>
            </header>
            <p>HoodSociety to sklep online z ubraniami, w którym znajdziesz najlepsze kroje z najmodniejszymi nadrukami. Zagleb sie w naszym katalogu a napewno znajdziesz cos dla siebie. Ponizej przedstawilismy pare przykladow wzorow dla kazdego elementu garderoby. </p>
        </div>
        <span class="image object">
            <style>
                    #pic {
                        box-shadow: 0px 0px 35px gray;
                    }
            </style>
            <img src="{$conf->app_url}/images/szwalnia.jpg" alt="" id="pic"/>
        </span>
    </section>

    <!-- Section -->
    <section>
        <header class="major">
            <h2>Zobacz wyroznione produkty z najnowszej kolekcji</h2>
        </header>
        <div class="posts">
            <article>
                <a class="image"><img src="{$conf->app_url}/images/koszulki.jpg" alt="" /></a>
                <h3>Koszulki</h3>
                <p>Zwykle koszulki tshirt z niewielkimi wzorami i nadrukami zapewniajace wyjatkowe, lecz schludne dodatki do gornej warstwy Twojego ubioru.</p>
                <ul class="actions">
                    <li><a href="{$conf->action_root}search/koszulki" class="button">Sprawdź</a></li>
                </ul>
            </article>
            <article>
                <a class="image"><img src="{$conf->app_url}/images/bluzy.jpg" alt="" /></a>
                <h3>Bluzy</h3>
                <p>Bluzy wykonane ze 100% bawelny, ktory poza swietnym wygladem zapewniaja ogrzanie i utrzymanie temperatury Twojego ciala w chlodniejsze dni.</p>
                <ul class="actions">
                    <li><a href="{$conf->action_root}search/bluzy" class="button">Sprawdź</a></li>
                </ul>
            </article>
            <article>
                <a class="image"><img src="{$conf->app_url}/images/bezrekawniki.jpg" alt="" /></a>
                <h3>Bezrękawniki</h3>
                <p>Koszulki bez rekawow, zapewniajace ochlode i przeplyw powietrza w upalne dni.</p>
                <ul class="actions">
                    <li><a href="{$conf->action_root}search/bezrekawniki" class="button">Sprawdź</a></li>
                </ul>
            </article>
            <article>
                <a class="image"><img src="{$conf->app_url}/images/spodnie.jpg" alt="" /></a>
                <h3>Spodnie</h3>
                <p>Wygodne spodnie zapewniajace komfort podczas uzytkowania, niezaleznie od tego czy cwiczysz na silowni, biegasz, czy potrzebujesz ich na codzien.</p>
                <ul class="actions">
                    <li><a href="{$conf->action_root}search/spodnie" class="button">Sprawdź</a></li>
                </ul>
            </article>
            <article>
                <a class="image"><img src="{$conf->app_url}/images/longsleeve.jpg" alt="" /></a>
                <h3>Koszulki longsleeve</h3>
                <p>Koszulki typu longsleeve z niewielkimi wzorami i nadrukami, dodatkowo zapewniajace utrzymanie temperatury na calym obszarze Twoich rak.</p>
                <ul class="actions">
                    <li><a href="{$conf->action_root}search/koszulki-longsleeve" class="button">Sprawdź</a></li>
                </ul>
            </article>
            <article>
                <a class="image"><img src="{$conf->app_url}/images/czapki.jpg" alt="" /></a>
                <h3>Czapki</h3>
                <p>Czapki z daszkiem wraz z niewielkimi wzorami.</p>
                <ul class="actions">
                    <li><a href="{$conf->action_root}search/czapki" class="button">Sprawdź</a></li>
                </ul>
            </article>


        </div>
    </section>
{/block}