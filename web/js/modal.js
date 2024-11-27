// Seleciona os elementos relevantes
const abrirDialogo = document.querySelector("#abrir-dialogo");
const fecharDialogo = document.querySelector("#fechar-dialogo");
const modal = document.querySelector("#dialog-compra");
const formCompra = document.querySelector("#form-compra");

// Abrir o modal ao clicar no botão "Comprar"
abrirDialogo.onclick = function () {
    modal.showModal();
};

// Abre o modal ao clicar no botão "abrir-dialogo"
abrirDialogo.onclick = function () {
    const campoCodigo = document.querySelector("#codigo-pedido");
    campoCodigo.value = gerarCodigoPedido(); // Gera e insere o código de pedido no campo
    modal.showModal(); // Abre o modal
};

// Fecha o modal ao clicar no botão "fechar-dialogo"
const closeButton = document.querySelector("#closeModal");
closeButton.onclick = function () {
modal.close();
};

// Função para gerar o código de pedido único
function gerarCodigoPedido() {
    const prefixo = "PED";
    const numeroAleatorio = Math.floor(100000 + Math.random() * 900000); // Número de 6 dígitos
    return `${prefixo}-${numeroAleatorio}`;
}


