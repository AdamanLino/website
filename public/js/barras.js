const graficoBarras = document.getElementById('graficoBarras');

new Chart(graficoBarras, {
    type: 'bar',
    data: {
        labels: ['Usuário 1', 'Usuário 2', 'Usuário 3'],
        datasets: [{
            label: 'Quantidade de Mensagens',
            data: [12, 20, 3],
            borderWidth: 1
        }]
    },
    options: {
    }
});