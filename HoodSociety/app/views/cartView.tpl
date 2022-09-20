{extends file="main.tpl"}

{block name=content}

    <div class="table-wrapper">
        <style>
            #cartTable td, #cartTable th {
                padding: 10px;
                vertical-align: middle;
                text-align: center;
                possition: absolute;
            }
            .center {
                text-align: center;
            }
        </style>
        <h2 class="center"><i class="icon solid fa-shopping-cart"></i> Koszyk</h2>
        {if count($cart) > 0}
            <table class="alt" id="cartTable">
                <thead>
                    <tr>
                        <th style="width: 500px">Produkt</th>
                        <th style="width: 60px">Ilość</th>
                        <th style="width: 100px">Cena za 1 szt.</th>
                        <th style="width: 100px">Razem</th>
                        <th style="width: 70px"></th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $cart as $c}
                        {strip}
                            <tr>
                                <td>{$c["name"]}</td>
                                <td>{$c["quantity"]} szt.</td>
                                <td>{number_format($c["price"], 2, ',', ' ')} zł</td>
                                <td>{number_format($c["price"] * $c["quantity"], 2, ',', ' ')} zł</td>
                                {$total = $total + ($c["price"] * $c["quantity"])}
                                <td><a onclick="confirmLink('{$conf->action_url}deleteFromCart/{$c["id_product"]}','Czy na pewno usunąć produkt?')" class="button primary small"><i class="fas fa-trash-alt"></i></a></td>
                            </tr>
                        {/strip}
                    {/foreach}
                </tbody>
                <tfoot>
                    <tr>
                        <td style="background-color: #43de52; color: black;">Razem do zapłaty:</td>
                        <td style="background-color: green;"></td>
                        <td style="background-color: green;"></td>
                        <td style="background-color: darkgreen; color: black;">{number_format($total, 2, ',', ' ')} zł</td>
                    </tr>
                </tfoot>
            </table>
            <a href="{$conf->action_root}orderNew" class="button primary medium" style="background-color: limegreen"><i class="fas fa-cash-register"></i> Realizuj zamówienie</a>
        {else}
            <h3 class="center">Twój koszyk jest pusty.</h3>
        {/if}
    </div>
{/block}
