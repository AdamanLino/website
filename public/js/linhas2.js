const graficoLinha2 = document.getElementById('graficoLinha2');

new Chart(graficoLinha2, {
    type: 'line',
    data: {
        labels: ['10:00', '11:00', '12:00'],
        datasets: [{
            label: 'Mensagens',
            data: [80, 54, 125],
            borderWidth: 1
        }]
    },
    options: {
    }
});