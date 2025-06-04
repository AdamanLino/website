// Função chamada ao carregar a página para obter e processar os dados
function obterDadosPizzaQuestionario() {
    // Aqui seria a função que obteria os dados do banco de dados
    fetch('/votos/ultimos/')
        .then(function (response) {
            return response.json();
        })
        .then(function (data) {
            plotarGraficoPizzaQuestionario(data); // Passando os dados corretamente para a função plotarGrafico
        })
        .catch(function (err) {
            console.log(err);
        });
}

// Função para plotar o gráfico com os dados
function plotarGraficoPizzaQuestionario(dados) {
    console.log('iniciando plotagem do gráfico...');

    // Criando estrutura para o gráfico de pizza
    let labels = [];
    let dadosGrafico = [];
    let pergunta = dados[0].pergunta;

    // Inserindo valores recebidos em estrutura para o gráfico
    for (let i = 0; i < dados.length; i++) {
        let registro = dados[i];
        labels.push(registro.alternativa);  // Usando 'assunto' como label
        dadosGrafico.push(registro.total_votos);  // Contagem de mensagens
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
                label: 'Total de Votos',
                data: dadosGrafico,
                color: 'rgba(255, 99, 132, 0.5)',
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
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: pergunta,
                    font: {
                        size: 18
                    }
                }
            }
        }
    };

    // Plotando o gráfico de pizza no canvas
    let myChart = new Chart(
        document.getElementById('graficoPizzaQuestionario'),  // Referência para o canvas
        config
    );
}