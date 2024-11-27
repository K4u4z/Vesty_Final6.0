function atualizarSubtotal(input) {
    const preco = parseFloat(input.getAttribute('data-preco'));
    const quantidade = parseInt(input.value);
    const subtotal = (preco * quantidade).toFixed(2);

    // Atualiza o subtotal no HTML
    const subtotalElement = input.closest('tr').querySelector('.subtotal');
    subtotalElement.textContent = `R$ ${subtotal}`;

    // Atualiza o total geral
    atualizarTotalGeral();

    // Atualiza o campo oculto de quantidade e subtotal no formulário
    const index = Array.from(document.querySelectorAll('.quantidade')).indexOf(input);
    document.querySelector(`input[name="produtos[${index}].quantidade"]`).value = quantidade;
    document.querySelector(`input[name="produtos[${index}].subtotal"]`).value = subtotal;
}

function atualizarTotalGeral() {
    const subtotais = Array.from(document.querySelectorAll('.subtotal')).map(el => parseFloat(el.textContent.replace('R$ ', '')));
    const totalGeral = subtotais.reduce((acc, val) => acc + val, 0).toFixed(2);

    document.getElementById('total-geral').textContent = `R$ ${totalGeral}`;
}

function validarCarrinho() {
    const tabelaCarrinho = document.getElementById('tabela-carrinho');
    
    // Verifica se a tabela e o tbody existem e contêm itens
    if (!tabelaCarrinho) {
        alert("Erro: A tabela do carrinho não foi encontrada.");
        return false;
    }

    const tbody = tabelaCarrinho.querySelector('tbody');
    if (!tbody || tbody.children.length === 0) {
        alert("Seu carrinho está vazio! Adicione produtos para continuar.");
        return false;
    }

    // Exibe o modal de compra
    const dialog = document.getElementById('dialog-compra');
    if (dialog) {
        dialog.showModal();
    }
}