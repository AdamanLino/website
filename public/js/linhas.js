const graficoLinha = document.getElementById('graficoLinha');

new Chart(graficoLinha, {
    type: 'line',
    data: {
        labels: ['10:00', '11:00', '12:00'],
        datasets: [{
            label: 'Postagens',
            data: [12, 20, 60],
            borderWidth: 1
        }]
    },
    options: {
    }
});