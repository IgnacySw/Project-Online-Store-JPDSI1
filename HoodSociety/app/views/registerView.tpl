{extends file="main.tpl"}

{block name=content}
    <section>					
        <form method="post" action="{$conf->action_root}register">
            <div class="row gtr-200">
                <div class="col-12 col-12-small align-center">
                <h2>Rejestracja</h2>
                </div>
                <div class="col-4 col-12-small align-right">
                    <p>Wpisz swój login:</p>
                </div>
                <div class="col-4 col-12-small">
                    <input type="text" name="login1" id="id_login1" value="{$r_form->login1}" placeholder="Login" />
                </div>
                <div class="col-4 col-12-small">
                    <p>(3 - 25 znaków)</p>
                </div>
                <div class="col-4 col-12-small align-right">
                    <p>Wpisz swoje hasło:</p>
                </div>
                <div class="col-4 col-12-small">
                    <input type="password" name="pass1" id="id_pass1" value="{$r_form->pass1}" placeholder="Hasło" />
                </div>
                <div class="col-4 col-12-small">
                    <p>(5 - 25 znaków)</p>
                </div>
                <div class="col-4 col-12-small align-right">
                    <p>Potwierdź swoje hasło:</p>
                </div>
                <div class="col-4 col-12-small">
                    <input type="password" name="pass2" id="id_pass2" value="{$r_form->pass2}" placeholder="Potwierdź hasło" />
                </div>
                <div class="col-4 col-12-small">
                </div>
                <div class="col-4 col-12-small">
                </div>
                <div class="col-4 col-12-small">
                    <ul class="actions">
                        <li><button class="button primary icon solid fa-user-plus" type="submit">Stwórz konto</button></li>
                        <li><a href="{$conf->action_root}loginShow" class="button icon solid fa-reply">Powrót</a></li>
                    </ul>
                </div>
                <div class="col-4 col-12-small">
                </div>
            </div>
        </form>
</section>
{/block}
