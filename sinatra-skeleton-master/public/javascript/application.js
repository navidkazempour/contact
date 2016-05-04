$(function() {

  // new contact method
  $('#new_contact').on('submit', function (event) {
    event.preventDefault()
    var name = document.getElementById('name').value;
    var email = document.getElementById('email').value;
    var phone_number = document.getElementById('phone_number').value;
    var contact = {name: name, email: email, phone_number: phone_number}

    if (name == '' || email == '' || phone_number == '') {
      return false;
    }

    $.ajax({
      type: "POST",
      url: '/contacts',
      data: contact,
      dataType: 'json',
      success: function(contact) {
        alert("Contact "+name+", saved.");
      }
    });
    clearValues();
  });

  function clearValues(){
    $('#name').val("");
    $('#email').val("");
    $('#phone_number').val("");
  }

  // search method
  $('#search').on('submit', function (event) {
    event.preventDefault()
    var search = document.getElementById('search_input').value;

    $.ajax({
      method: "get",
      url: '/search/'+search,
      dataType: 'json',
      success: function(contacts) {
        var table = $('#result').find('thead').empty();
        var th = $('<tr>').appendTo(table);
        $('<th>').appendTo(th).text("Name");
        $('<th>').appendTo(th).text("Email");
        $('<th>').appendTo(th).text("Phone Number");
       
        console.log(table);
        var table_body = $('#result').find('tbody').empty();
        contacts.forEach(function(contact){
          
          var tr = $('<tr>').appendTo(table_body);
          $('<td>').appendTo(tr).text(contact.name);
          $('<td>').appendTo(tr).text(contact.email);
          $('<td>').appendTo(tr).text(contact.phone_number);
        });
      }
    });
    $('#search_input').val('');
  });

}); //for the main function()


