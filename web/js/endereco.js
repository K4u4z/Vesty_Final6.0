//Quando a pagina for carregada completamente, executa a função

window.onload = function(){
    const modal = document.querySelector("dialog");

    const formularioCompra = document.getElementById('form-compra');
    
    // Obtém o campo de entrada do CEP pelo ID
    const cepInput = document.getElementById('cep');

    // Adiciona um ouvinte de evento quando o campo CEP perde o foco (blur)
    cepInput.addEventListener('blur', function() {
        // Remove todos os caracteres não numéricos do CEP
        const cep = this.value.replace(/\D/g, '');

        // Verifica se o CEP tem exatamente 8 dígitos
        if (cep.length === 8) {
            // URL da API com o CEP inserido
            const url = `https://viacep.com.br/ws/${cep}/json/`;

            // Faz uma requisição para a API ViaCEP com o CEP informado
            fetch(url)
                .then(function(response) {
                    // Verifica se a resposta da requisição está ok (status 200)
                    if (!response.ok) {
                        throw new Error('Erro na resposta da rede');
                    }
                    // Converte a resposta para JSON
                    return response.json();
                })
                .then(function(data) {
                    // Verifica se não ocorreu um erro na resposta da API
                    if (!('erro' in data)) {
                        // Preenche os campos com os dados retornados pela API
                        document.getElementById('txtRua').value = data.logradouro;
                        document.getElementById('txtBairro').value = data.bairro;
                        document.getElementById('txtCidade').value = data.localidade;
                        document.getElementById('txtEstado').value = data.uf;
                    } else {
                        // Se o CEP não for encontrado, exibe uma mensagem de alerta
                        alert('CEP não encontrado.');
                        // Limpa os campos de endereço
                        clearAddressFields();
                    }
                })
                .catch(function(error) {
                    // Em caso de erro na requisição, exibe uma mensagem de alerta
                    alert('Erro ao buscar o CEP: ' + error.message);
                });
        } else {
            // Se o CEP não tiver 8 dígitos, exibe uma mensagem de alerta
            alert('CEP inválido. O CEP deve conter 8 dígitos.');
            // Limpa os campos de endereço
            clearAddressFields();
        }
    });

    // Função para limpar os campos de endereço
    function clearAddressFields() {
        document.getElementById('txtRua').value = '';
        document.getElementById('txtBairro').value = '';
        document.getElementById('txtCidade').value = '';
        document.getElementById('txtEstado').value = '';
    }

    // Adiciona um ouvinte de evento ao submeter o formulário
    formularioCompra.addEventListener('submit', function(event) {
        // Previne o comportamento padrão de recarregar a página ao enviar o formulário
        event.preventDefault();



        // Verifica se os campos de endereço estão preenchidos
        const street = document.getElementById('txtRua').value;
        if (street === '') {
            alert('Por favor, preencha um CEP válido para obter o endereço.');
            return;
        }

        
    });
};