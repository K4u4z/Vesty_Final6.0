 function showPopup(nomeProduto) {
            const popup = document.getElementById('popup');
            popup.textContent = `Produto "${nomeProduto}" foi adicionado com sucesso!`;
            popup.style.display = 'block';
            
            // Esconde o popup após 3 segundos
            setTimeout(() => {
                popup.style.display = 'none';
            }, 3000);
        }