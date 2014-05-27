// spree's version handles 'input', and 'select', but then select2 doesn't work correctly

$(function () {
  $('.spree_add_fields').off('click').on('click', function() {
    var target = $(this).data("target");
    var new_table_row = $(target + ' tr:first').clone();
    var new_id = new Date().getTime();
    new_table_row.find("select").each(function () {
      var el = $(this);
      new_table_row.find("#s2id_"+el.prop('id')).remove();
    });
    new_table_row.find("input, select").each(function () {
      var el = $(this);
      el.val("");
      el.prop("id", el.prop("id").replace(/\d+/, new_id))
      el.prop("name", el.prop("name").replace(/\d+/, new_id))
    });
    new_table_row.show();
    // When cloning a new row, set the href of all icons to be an empty "#"
    // This is so that clicking on them does not perform the actions for the
    // duplicated row (Warning: clears javascript in href)
    new_table_row.find("a").each(function () {
      var el = $(this);
      el.prop('href', '#');
    });
    $(target).append(new_table_row);
    new_table_row.find('.select2').select2();
  });

});
