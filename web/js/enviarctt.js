var formulario = document.getElementById('frmContato');
var nomec = document.getElementById('txtNomec');
var emailc = document.getElementById('txtEmailc');
var assuntoc = document.getElementById('txtAssuntoc');
var mensagemc = document.getElementById('txtMensagemc');

formulario.addEventListener('submit', function (event) {
    if(nomec.value != null && emailc.value != null && assuntoc != null && mensagemc !=null){
    alert('Formulário enviado com sucesso');
    }
}
);








