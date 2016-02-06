<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-bar-chart"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <div class="well">
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="control-label" for="input-date-start"><?php echo $entry_date_start; ?></label>
                <div class="input-group date">
                  <input type="text" name="filter_date_start" value="<?php echo $filter_date_start; ?>" placeholder="<?php echo $entry_date_start; ?>" data-date-format="YYYY-MM-DD" id="input-date-start" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              <div class="form-group">
                <label class="control-label" for="input-date-end"><?php echo $entry_date_end; ?></label>
                <div class="input-group date">
                  <input type="text" name="filter_date_end" value="<?php echo $filter_date_end; ?>" placeholder="<?php echo $entry_date_end; ?>" data-date-format="YYYY-MM-DD" id="input-date-end" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="control-label" for="input-status"><?php echo $entry_status; ?></label>
                <select name="filter_order_status_id" id="input-status" class="form-control">
                  <option value="0"><?php echo $text_all_status; ?></option>
                  <?php foreach ($order_statuses as $order_status) { ?>
                  <?php if ($order_status['order_status_id'] == $filter_order_status_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
              <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
            </div>
          </div>
        </div>
        <div class="table-responsive">
          <table class="table table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-left"><?php echo $column_country; ?></td>
                <td class="text-right"><?php echo $column_orders; ?></td>
                <td class="text-right"><?php echo $column_total; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php if ($customers) { ?>
			  <?php if ($filter_country_id != "") { ?>
			  <?php
				$back_url = "index.php?route=report/customer_country&token=".$token;
				if ($filter_date_start != "")
					$back_url .= "&filter_date_start=".$filter_date_start;
				if ($filter_date_end != "")
					$back_url .= "&filter_date_end=".$filter_date_end;
				if ($filter_order_status_id != "")
					$back_url .= "&filter_order_status_id=".$filter_order_status_id;	
					
				?>
				    <tr><td class="text-left" colspan="3"><a class="btn btn-info" href="<?php echo $back_url; ?>"><i class="fa fa-arrow-left"></i> BACK</a></td></tr>
					<tr><td style="background-color:#f5f5f5; padding-top:15px; padding-left:15px;" class="text-left" colspan="3"><h3><i class="fa fa-flag"> <?php echo $customers[0]['name']; ?></h3></td>
              <?php }  ?>
              <?php foreach ($customers as $customer) { ?>
              <tr>
				<?php if ($filter_country_id != "") { ?>
					<td class="text-left"><?php echo $customer['zone']; ?></td>
                <?php } else { ?>
					<?php
					$country_url = "index.php?route=report/customer_country&token=".$token."&filter_country_id=".$customer['country_id'];
					if ($filter_date_start != "")
						$country_url .= "&filter_date_start=".$filter_date_start;
					if ($filter_date_end != "")
						$country_url .= "&filter_date_end=".$filter_date_end;
					if ($filter_order_status_id != "")
						$country_url .= "&filter_order_status_id=".$filter_order_status_id;	
					?>
					<td class="text-left"><a href="<?php echo $country_url; ?>"><?php echo $customer['name']; ?></a></td></td>
                <?php } ?>
                <td class="text-right"><?php echo $customer['count']; ?></td>
                <td class="text-right"><?php echo $customer['total']; ?></td>
              </tr>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	<?php if(isset($filter_country_id)) { ?>
		url = 'index.php?route=report/customer_country&token=<?php echo $token; ?>&filter_country_id=<?php echo $filter_country_id; ?>';
	<?php }	else { ?>
		url = 'index.php?route=report/customer_country&token=<?php echo $token; ?>';
	<?php } ?>
	
	var filter_date_start = $('input[name=\'filter_date_start\']').val();
	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').val();
	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}
	
	var filter_order_status_id = $('select[name=\'filter_order_status_id\']').val();
	
	if (filter_order_status_id != 0) {
		url += '&filter_order_status_id=' + encodeURIComponent(filter_order_status_id);
	}	

	location = url;
});
//--></script> 
  <script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
//--></script></div>
<?php echo $footer; ?>