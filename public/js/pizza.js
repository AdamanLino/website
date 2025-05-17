const graficoPizza = document.getElementById('graficoPizza');

new Chart(graficoPizza, {
    type: 'pie',
    data: {
        labels: ['Postagem 1', 'Postagem 2', 'Postagem 3'],
        datasets: [{
            label: 'Quantidade de Respostas',
            data: [12, 19, 3],
            borderWidth: 1
        }]
    },
    options: {
    }
});