<div class="col-12 col-12-small">
    {if $searchForm->query != ''}
        {if count($products) > 0}
            <p>Wyniki wyszukiwania "{$searchForm->query}" ({$pages->recNum}), strona: {$pages->currentPage} z {$pages->lastPage}</p>
        </div>
        <div class="center">
            <ul class="pagination">
                {if $pages->currentPage < 2}
                    <li><button class="button disabled"><<</button></li>
                    <li><button class="button disabled"><</button></li>
                    {else}
                    <li><button onclick="ajaxPostForm('search-form', '{$conf->action_root}productListTable', 'products');"><<</button></li>
                    <li><button onclick="ajaxPostForm('search-form', '{$conf->action_root}productListTable/{$pages->currentPage-1}', 'products');"><</button></li>
                    {/if}


                {if $pages->currentPage < 2}
                    <li><a class="page"></a></li>
                    {else}
                    <li><a class="page">1</a></li>
                    {/if}

                {if $pages->currentPage < 3}
                {else}
                    <li><span>&hellip;</span></li>
                    {/if}

                <li><a class="page active">&nbsp;&nbsp;{$pages->currentPage}&nbsp;&nbsp;</a></li>

                {if ($pages->lastPage - $pages->currentPage) < 2}
                {else}
                    <li><span>&hellip;</span></li>
                    {/if}

                {if $pages->currentPage >= $pages->lastPage}
                    <li><a class="page"></a></li>
                    {else}
                    <li><a class="page">{$pages->lastPage}</a></li>
                    {/if}


                {if $pages->currentPage > $pages->lastPage-1}
                    <li><button class="button disabled">></button></li>
                    <li><button class="button disabled">>></button></li>
                    {else}
                    <li><button onclick="ajaxPostForm('search-form', '{$conf->action_root}productListTable/{$pages->currentPage+1}', 'products');">></button></li>
                    <li><button onclick="ajaxPostForm('search-form', '{$conf->action_root}productListTable/{$pages->lastPage}', 'products');">>></button></li>
                    {/if}
            </ul>
        </div>
        <div class="table-wrapper">
            <table class="alt" id="products">
                <thead>
                    <tr>
                        <th style="width: 350px">Nazwa</th>
                        <th>Opis</th>
                        <th style="width: 100px">Cena</th>
                        <th style="width: 200px"></th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $products as $p}
                        {strip}
                            <tr>
                                <td>{$p['name']}</td>
                                <td><p>{substr($p['description'], 0, 60)}<span id="dots{$p['id_product']}">...</span><span style="display: none;" id="more{$p['id_product']}">{substr($p['description'], 60)}</span></p><button class="button small" onclick="description({$p['id_product']})" id="myBtn{$p['id_product']}">Rozwiń opis</button></td>
                                <td>{number_format($p['price'], 2, ',', ' ')} zł</td>
                                <td>
                                    <div class="center">
                                        <a class="button primary medium icon solid fa-cart-plus" style="background-color:rgb(30, 200, 50);" href="{$conf->action_url}addToCart/{$p['id_product']}">Do koszyka</a>
                                    </div>
                                </td>
                            </tr>
                        {/strip}
                    {/foreach}
                </tbody>
            </table>
            <div class="center">
                <ul class="pagination">
                    {if $pages->currentPage < 2}
                        <li><button class="button disabled"><<</button></li>
                        <li><button class="button disabled"><</button></li>
                        {else}
                        <li><button onclick="ajaxPostForm('search-form', '{$conf->action_root}productListTable', 'products');"><<</button></li>
                        <li><button onclick="ajaxPostForm('search-form', '{$conf->action_root}productListTable/{$pages->currentPage-1}', 'products');"><</button></li>
                        {/if}


                    {if $pages->currentPage < 2}
                        <li><a class="page"></a></li>
                        {else}
                        <li><a class="page">1</a></li>
                        {/if}

                    {if $pages->currentPage < 3}
                    {else}
                        <li><span>&hellip;</span></li>
                        {/if}

                    <li><a class="page active">&nbsp;&nbsp;{$pages->currentPage}&nbsp;&nbsp;</a></li>

                    {if ($pages->lastPage - $pages->currentPage) < 2}
                    {else}
                        <li><span>&hellip;</span></li>
                        {/if}

                    {if $pages->currentPage >= $pages->lastPage}
                        <li><a class="page"></a></li>
                        {else}
                        <li><a class="page">{$pages->lastPage}</a></li>
                        {/if}


                    {if $pages->currentPage > $pages->lastPage-1}
                        <li><button class="button disabled">></button></li>
                        <li><button class="button disabled">>></button></li>
                        {else}
                        <li><button onclick="ajaxPostForm('search-form', '{$conf->action_root}productListTable/{$pages->currentPage+1}', 'products');">></button></li>
                        <li><button onclick="ajaxPostForm('search-form', '{$conf->action_root}productListTable/{$pages->lastPage}', 'products');">>></button></li>
                        {/if}
                </ul>
            </div>
        {else}
            <p>Nie znaleziono wyników dla "{$searchForm->query}"</p>
        {/if}
    {else}
        <p>Nie podano zapytania!</p>
    {/if}
    <script>
        function description(id) {
            var dots = document.getElementById("dots" + id.toString());
            var moreText = document.getElementById("more" + id.toString());
            var btnText = document.getElementById("myBtn" + id.toString());

            if (dots.style.display === "none") {
                dots.style.display = "inline";
                btnText.innerHTML = "Rozwiń opis";
                moreText.style.display = "none";
            } else {
                dots.style.display = "none";
                btnText.innerHTML = "Zwiń opis";
                moreText.style.display = "inline";
            }
        }
    </script>
</div>

