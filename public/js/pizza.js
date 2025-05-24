// Função chamada ao carregar a página para obter e processar os dados
function obterDadosPizza() {
    // Aqui seria a função que obteria os dados do banco de dados
    fetch('/mensagens/ultimas/')
        .then(function (response) {
            return response.json();
        })
        .then(function (data) {
            plotarGraficoPizza(data); // Passando os dados corretamente para a função plotarGrafico
        })
        .catch(function (err) {
            console.log(err);
        });
}

// Função para plotar o gráfico com os dados
function plotarGraficoPizza(dados) {
    console.log('iniciando plotagem do gráfico...');

    // Criando estrutura para o gráfico de pizza
    let labels = [];
    let dadosGrafico = [];

    // Inserindo valores recebidos em estrutura para o gráfico
    for (let i = 0; i < dados.length; i++) {
        let registro = dados[i];
        labels.push(registro.assunto);  // Usando 'assunto' como label
        dadosGrafico.push(registro.total_mensagens);  // Contagem de mensagens
    }

    console.log('O gráfico será plotado com os seguintes valores:');
    console.log('Labels:', labels);
    console.log('Dados:', dadosGrafico);

    // Configurando o gráfico de pizza
    const config = {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                label: 'Postagens Mais Populares',
                data: dadosGrafico,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.5)',
                    'rgba(54, 162, 235, 0.5)',
                    'rgba(255, 206, 86, 0.5)',
                    'rgba(75, 192, 192, 0.5)',
                    'rgba(153, 102, 255, 0.5)',
                    'rgba(255, 159, 64, 0.5)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true
        }
    };

    // Plotando o gráfico de pizza no canvas
    let myChart = new Chart(
        document.getElementById('graficoPizza'),  // Referência para o canvas
        config
    );
}