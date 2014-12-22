<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">

    <div class="left-panel">
      <div class="logo"><h1><?php echo $heading_title; ?> </h1></div>
      <div class="slidebar"><?php require( dirname(__FILE__).'/toolbar.tpl' ); ?></div>
      <div class="clear clr"></div>
    </div>
    <div class="right-panel">
      <div class="heading">
        <h1><?php echo $this->language->get("text_subscribes"); ?></h1>
      </div>
      <div class="content">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
          <input type="hidden" name="action" id="action" value=""/>
          <table class="list">
            <thead>
              <tr>
                <td class="left"><?php if ($sort == 'name') { ?>
                  <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_name; ?>"><?php echo $this->language->get("column_name"); ?></a>
                  <?php } ?></td>
                <td class="left"><?php if ($sort == 'email') { ?>
                  <a href="<?php echo $sort_email; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_email; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_email; ?>"><?php echo $column_email; ?></a>
                  <?php } ?></td>
                <td class="right"><?php if ($sort == 'customer_group_id') { ?>
                  <a href="<?php echo $sort_customer_group_id; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_customer_group; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_customer_group_id; ?>"><?php echo $column_customer_group; ?></a>
                  <?php } ?></td>
                <td class="right"><?php if ($sort == 's.action') { ?>
                  <a href="<?php echo $sort_subscribe; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_subscribe; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_subscribe; ?>"><?php echo $column_subscribe; ?></a>
                  <?php } ?></td>
                <td class="right"><?php if ($sort == 's.store_id') { ?>
                  <a href="<?php echo $sort_store_id; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_store; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_store_id; ?>"><?php echo $column_store; ?></a>
                  <?php } ?></td>
                <td class="right"><?php echo $column_action; ?></td>
              </tr>
            </thead>
            <tbody>
              <tr class="filter">
                <td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" /></td>
                <td><input type="text" name="filter_email" value="<?php echo $filter_email; ?>" /></td>
                <td align="right"><select name="filter_customer_group_id">
                    <option =""></option>
                    <?php if(isset($customer_groups)):?>
                    <?php foreach($customer_groups as $key=>$val):?>
                      <option value="<?php echo $key;?>" <?php if($key==$filter_customer_group_id) echo 'selected="selected"';?>><?php echo $val;?></option>
                  <?php endforeach; ?>
                  <?php endif;?>
                </select></td>
                <td align="right"><select name="filter_action">
                    <option value=""></option>
                    <?php if ($filter_action == "1") { ?>
                    <option value="1" selected="selected"><?php echo $this->language->get("text_yes"); ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $this->language->get("text_yes"); ?></option>
                    <?php } ?>
                    <?php if ($filter_action == "0") { ?>
                    <option value="0" selected="selected"><?php echo $this->language->get("text_no"); ?></option>
                    <?php } else { ?>
                    <option value="0"><?php echo $this->language->get("text_no"); ?></option>
                    <?php } ?>
                  </select></td>
                <td align="right"><select name="filter_store_id">
                    <option value=""></option>
                    <?php
                    if(isset($stores)):
                      foreach($stores as $key=>$val):
                          ?>
                          <option value="<?php echo $key;?>" <?php if($filter_store_id!="" && $key==$filter_store_id) echo 'selected="selected"';?>><?php echo $val; ?></option>
                        <?php
                      endforeach;
                      endif;
                    ?>
                  </select></td>
                <td align="right"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a></td>
              </tr>
              <?php if ($subscribes) { ?>
              <?php foreach ($subscribes as $subsribe) { ?>
              <tr>
                <td class="left"><?php echo $subsribe['name']; ?></td>
                <td class="left"><?php echo $subsribe['email']; ?></td>
                <td class="left"><?php echo $subsribe['customer_group']; ?></td>
                <td class="right"><?php echo $subsribe['subscribe'];?></td>
                <td class="right"><?php echo $subsribe['store']; ?></td>
                <td class="right"><?php foreach ($subsribe['action'] as $action) { ?>
                  [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                  <?php } ?></td>
              </tr>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="center" colspan="6"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </form>
        <div class="pagination"><?php echo $pagination; ?></div>
      </div>
      </div>
    <div class="clear clr"></div>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
  url = 'index.php?route=module/pavnewsletter/subsribes&token=<?php echo $token; ?>';
  
  var filter_name = $('input[name=\'filter_name\']').attr('value');
  
  if (filter_name) {
    url += '&filter_name=' + encodeURIComponent(filter_name);
  }
  
  var filter_email = $('input[name=\'filter_email\']').attr('value');
  
  if (filter_email) {
    url += '&filter_email=' + encodeURIComponent(filter_email);
  }
  
  var filter_customer_group_id = $('select[name=\'filter_customer_group_id\']').attr('value');
  
  if (filter_customer_group_id) {
    url += '&filter_customer_group_id=' + encodeURIComponent(filter_customer_group_id);
  }
  
  var filter_action = $('select[name=\'filter_action\']').attr('value');
  
  if (filter_action) {
    url += '&filter_action=' + encodeURIComponent(filter_action);
  }
  
  var filter_store = $('select[name=\'filter_store_id\']').attr('value');
  
  if (filter_store != '') {
    url += '&filter_store_id=' + encodeURIComponent(filter_store);
  } 

  location = url;
}
//--></script> 
<script type="text/javascript"><!--
$('#form input').keydown(function(e) {
  if (e.keyCode == 13) {
    filter();
  }
});
//--></script>
<?php echo $footer; ?>