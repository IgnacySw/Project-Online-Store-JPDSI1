{extends file="main.tpl"}

{block name=content}
    <section>					
        <form method="post" action="{$conf->action_url}finalizeAddNewProduct">
            <div class="row gtr-200">
                <div class="col-12 col-12-small align-center">
                    <h2>Dodanie nowego produktu</h2>
                </div>
                <div class="col-3 col-12-small align-right">
                    <p>Nazwa nowego produktu wyswietlana w sklepie:</p>
                </div>
                <div class="col-6">
                    <textarea name="address" id="id_address" rows="1" value="{$address_form->address}" placeholder="Wpisz nazwe produktu"></textarea>
                </div>
                <div class="col-12">
                    <p></p>
                </div>
                <div class="col-3 col-12-small align-right">
                    <p>Opis produktu:</p>
                </div>
                <div class="col-6">
                    <input type="text" name="address" id="id_address" value="{$address_form->address}" placeholder="Wpisz opis produktu"/>
                </div>
                <div class="col-12">
                    <p></p>
                </div>
				<div class="col-3 col-12-small align-right">
                    <p>Cena produktu:</p>
                </div>
                <div class="col-6">
                    <input type="text" name="phone" id="id_phone" value="{$address_form->phone}" placeholder="Wpisz cene produktu w zl"/>
                </div>
                <div class="col-12">
                    <p></p>
                </div>
                <div class="col-3 col-12-small align-right">
                    <p>Kategoria produktu:</p>
                </div>
                <div class="col-6">
                    <input type="text" name="email" id="id_email" value="{$address_form->email}" placeholder="Wybierz kategorie produktu"/>
                </div>
                <div class="col-12">
                    <p></p>
                </div>
                <div class="col-3 col-12-small">
                </div>
                <div class="col-6 col-12-small">
                    <ul class="actions">
                        <li><a href="{$conf->action_url}shopShow" class="button"><i class="fas fa-arrow-circle-left"></i> Strona Glowna</a></li>
                        <li><button class="button primary" type="submit" style="background-color:rgb(30, 200, 50);"><i class="far fa-plus"></i> Dodaj produkt</button></li>
                    </ul>
                </div>
            </div>
        </form>
    </section>
{/block}