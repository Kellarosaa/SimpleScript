<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SimpleScript</title>
</head>
<body>
    <div id="output"></div>

    <script>
        fetch('https://raw.githubusercontent.com/Kellarosaa/ss-workload/refs/heads/main/index.ss')
            .then(response => response.text())
            .then(data => {
                const regex = /text\((.*?)\)/g;
                let matches;
                let output = '';

                while ((matches = regex.exec(data)) !== null) {
                    output += matches[1] + '<br>';
                }

                document.getElementById('output').innerHTML = output;
            })
            .catch(error => console.error('Error fetching the file:', error));
    </script>
</body>
</html>
    <style>
        .redirect-link {
            color: blue;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div id="content"></div>

    <script>
        async function fetchGitHubFile() {
            const response = await fetch('https://raw.githubusercontent.com/Kellarosaa/ss-workload/refs/heads/main/index.ss');
            const text = await response.text();
            const regex = /https:\/\/[^\s]+/g;
            const matches = text.match(regex);
            const contentDiv = document.getElementById('content');

            if (matches) {
                matches.forEach(url => {
                    const link = document.createElement('a');
                    link.href = url;
                    link.className = 'redirect-link';
                    link.target = '_blank';
                    link.innerText = url;
                    contentDiv.appendChild(link);
                    contentDiv.appendChild(document.createElement('br'));
                });
            } else {
                contentDiv.innerText = 'No links found.';
            }
        }

        fetchGitHubFile();
    </script>
</body>
</html>
    <style>
        .bar {
            display: flex;
            height: 25px;
            width: 100%;
            background-color: #e0e0e0;
            position: fixed;
            bottom: 10;
        }
        .segment {
            height: 100%;
            position: relative;
        }
        .html { background-color: pink; }
        .ss { background-color: blue; }
        .smdl { background-color: purple; }
        .label {
            position: absolute;
            right: 5px;
            color: white;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="bar" id="progressBar"></div>

    <script>
        async function fetchAndCalculate() {
            const urls = [
                "https://raw.githubusercontent.com/Kellarosaa/ss-workload/refs/heads/main/index.ss",
                "https://raw.githubusercontent.com/Kellarosaa/ss-workload/refs/heads/main/README.smdl",
                "https://raw.githubusercontent.com/Kellarosaa/ss-workload/refs/heads/main/index.html"
            ];

            const results = await Promise.all(urls.map(url => fetch(url).then(res => res.text())));
            const lengths = results.map(text => text.length);
            const totalLength = lengths.reduce((a, b) => a + b, 0);
            const percentages = lengths.map(length => (length / totalLength) * 100);

            const bar = document.getElementById('progressBar');
            const colors = ['ss', 'smdl', 'html'];
            const labels = ['SS', 'SMDL', 'HTML'];

            percentages.forEach((percentage, index) => {
                const segment = document.createElement('div');
                segment.className = `segment ${colors[index]}`;
                segment.style.width = `${percentage}%`;
                segment.innerHTML = `<span class="label">${labels[index]}: ${percentage.toFixed(2)}%</span>`;
                bar.appendChild(segment);
            });
        }

        fetchAndCalculate();
    </script>
</body>
</html>
