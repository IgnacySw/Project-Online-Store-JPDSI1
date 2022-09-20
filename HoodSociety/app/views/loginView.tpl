{extends file="main.tpl"}

{block name=content}
    <section>					
        <form method="post" action="{$conf->action_root}login">
            <div class="row gtr-200">
                <div class="col-12 col-12-small align-center">
                    <h2>Logowanie</h2>
                </div>
                <div class="col-4 col-12-small align-right">
                    <p>Login:</p>
                </div>
                <div class="col-4 col-12-small">
                    <input type="text" name="login" id="id_login" value="{$l_form->login}" placeholder="Login" />
                </div>
                <div class="col-4 col-12-small">
                </div>
                <div class="col-4 col-12-small align-right">
                    <p>Hasło:</p>
                </div>
                <div class="col-4 col-12-small">
                    <input type="password" name="pass" id="id_pass" value="{$l_form->pass}" placeholder="Hasło" />
                </div>
                <div class="col-4 col-12-small">
                </div>
                <div class="col-4 col-12-small">
                </div>
                <div class="col-4 col-12-small">
                    <ul class="actions">
                        <li><button class="button primary icon solid fa-sign-in-alt" type="submit">Zaloguj</button></li>
                        <li><a href="{$conf->action_root}registerShow" class="button icon solid fa-user-plus">Nowe konto</a></li>
                    </ul>
                </div>
            </div>
        </form>
</section>
{/block}
