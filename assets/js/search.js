const searchInput = document.getElementById('searchInput');
const suggestionsList = document.getElementById('suggestionsList');
let currentIndex = -1;

const suggestions = [
    'CAN TRƯỜNG BƯỚC TIẾP (TÁI BẢN 2023)', 
    'GÁNH GÁNH... GỒNG GỒNG... (XUÂN PHƯỢNG HỒI KÝ)', 
    'STORYTELLING WITH DATA - KỂ CHUYỆN THÔNG QUA DỮ LIỆU', 
    'CÂY CAM NGỌT CỦA TÔI', 
    'BÀN CÓ NĂM CHỖ NGỒI (TÁI BẢN 2022)'
]; // Example suggestions

searchInput.addEventListener('input', function() {
    const input = this.value.toLowerCase();
    suggestionsList.innerHTML = '';
    currentIndex = -1; // Reset the index when input changes
    if (input.length > 0) {
        const filteredSuggestions = suggestions.filter(item => item.toLowerCase().includes(input));
        filteredSuggestions.forEach(item => {
            const li = document.createElement('li');
            li.textContent = item;
            suggestionsList.appendChild(li);
        });
        suggestionsList.style.display = 'block';
    } else {
        suggestionsList.style.display = 'none';
    }
});

searchInput.addEventListener('keydown', function(e) {
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
        }
    }
});

document.addEventListener('click', function(e) {
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
