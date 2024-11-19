document.addEventListener("DOMContentLoaded", function () {
    fetchDataDSBOOKFromServer();
});

function fetchDataDSBOOKFromServer() {
    fetch('http://localhost:5000/dsbook')
        .then(response => response.json())
        .then(data => {
            if (Object.keys(data).length === 0) {
                console.log("Dữ liệu rỗng!");
            } else {
                console.log(data);
                sessionStorage.setItem('dsbook', JSON.stringify(data));
            }
        })
        .catch(error => console.error('Lỗi:', error));
}

const searchInput = document.getElementById('searchInput');
const suggestionsList = document.getElementById('suggestionsList');
const searchBtn = document.getElementById('btn_timKiem');
let currentIndex = -1;

searchInput.addEventListener('input', function () {
    var searchds = JSON.parse(sessionStorage.getItem('dsbook'));
    const input = this.value.toLowerCase();
    suggestionsList.innerHTML = '';
    currentIndex = -1; // Reset the index when input changes
    if (input.length > 0) {
        const filteredSuggestions = searchds.filter(item => item.Name.toLowerCase().includes(input)).slice(0, 5);;
        filteredSuggestions.forEach(item => {
            const li = document.createElement('li');
            const a = document.createElement('a');
            a.textContent = item.Name;
            a.href = "/WSearch";
            li.appendChild(a);
            li.addEventListener('click', function (e) {
                sessionStorage.setItem('wordsearchdsall', JSON.stringify(a.textContent));
                window.location.href = a.href;
            });
            suggestionsList.appendChild(li);
            suggestionsList.style.display = 'block';
        });
        suggestionsList.style.display = 'block';
    } else {
        suggestionsList.style.display = 'none';
    }
});

searchInput.addEventListener('keydown', function (e) {
    const items = suggestionsList.getElementsByTagName('li');
    if (e.key === 'ArrowDown') {
        if (currentIndex < items.length - 1) {
            currentIndex++;
            updateHighlight(items);
        }
    } else if (e.key === 'ArrowUp') {
        if (currentIndex > 0) {
            currentIndex--;
            updateHighlight(items);
        }
    } else if (e.key === 'Enter') {
        if (currentIndex > -1 && currentIndex < items.length) {
            searchInput.value = items[currentIndex].textContent;
            suggestionsList.style.display = 'none';
            sessionStorage.setItem('wordsearchdsall', JSON.stringify(searchInput.value));
            window.location.href = '/WSearch';
        } else {
            sessionStorage.setItem('wordsearchdsall', JSON.stringify(searchInput.value));
            window.location.href = '/WSearch';
        }
    }
});

searchBtn.addEventListener('click', function (e) {
    if (searchInput.value != "") {
        sessionStorage.setItem('wordsearchdsall', JSON.stringify(searchInput.value));
        window.location.href = '/WSearch';
    }
});

document.addEventListener('click', function (e) {
    if (!searchInput.contains(e.target) && !suggestionsList.contains(e.target)) {
        suggestionsList.style.display = 'none';
    }
});

function updateHighlight(items) {
    for (let i = 0; i < items.length; i++) {
        items[i].classList.remove('highlighted');
    }
    if (currentIndex > -1 && currentIndex < items.length) {
        items[currentIndex].classList.add('highlighted');
    }
}

