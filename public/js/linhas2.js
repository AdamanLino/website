
// Função chamada ao carregar a página para obter e processar os dados
function obterDadosLinha2() {
    // Aqui seria o endereço criado anteriormente função que obteria os dados do banco de dados
    fetch('/mensagens/novas/')
        .then(function (response) {
            return response.json();
        })
        .then(function (data) {
            plotarGraficoLinha2(data); // Passando os dados corretamente para a função plotarGrafico
        })
        .catch(function (err) {
            console.log(err);
        });
}

// Função para plotar o gráfico com os dados
function plotarGraficoLinha2(dados) {
    console.log('iniciando plotagem do gráfico...');

    // Criando estrutura para o gráfico de barras
    let labels = [];
    let dadosGrafico = [];

    // Inserindo valores recebidos em estrutura para o gráfico
    for (let i = 0; i < dados.length; i++) {
        let registro = dados[i];
        labels.push(registro.hora);  // Passe aqui a label do que você está tentando buscar no select do bd
        dadosGrafico.push(registro.total_mensagens);  // Passe aqui os dados que você está tentando buscar no select bd
    }

    console.log('O gráfico será plotado com os seguintes valores:');
    console.log('Labels:', labels);
    console.log('Dados:', dadosGrafico);

    // Configurando o gráfico de linhas
    const config = {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: "Novas Mensagens",
                data: dadosGrafico,
                backgroundColor: [
                    'rgba(54, 162, 235, 0.6)'
                ],
                borderColor: 'rgb(75, 192, 192)',
                tension: 0.1,
                borderWidth: 1
            }]
        },
        options: {
            responsive: true
        }
    };

    // Plotando o gráfico de barras no canvas
    let myChart = new Chart(
        document.getElementById('graficoLinha2'),  // Chamando o gráfico pelo ID do canvas
        config
    );
}