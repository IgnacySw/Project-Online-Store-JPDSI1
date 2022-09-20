{extends file="main.tpl"}

{block name=content}
        
            <style>
                #products{
                    border-collapse: collapse;
                }
                #products th{
                    padding-top: 12px;
                    padding-bottom: 12px;
                    background-color: #43de52;
                    color: white;
                }
                #products td, #products th {
                    border: 1px solid black;
                    padding: 10px;
                    vertical-align: middle;
                    horizontal-align: middle;
                    text-align: center;
                    margin-left: auto;
                    margin-right: auto;
                }
                .center {
                    text-align: center;
                }
            </style>
            
            
            <div id="products">
                {include file="productListViewTable.tpl"}
            </div>
            
{/block}