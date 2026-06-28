(() => {
    const searchBox = document.getElementById("searchBox");
    const results = document.getElementById("searchResults");

    let debounceTimer;

    if (!searchBox || !results) return;

    searchBox.addEventListener("keyup", function () {
        const keyword = this.value.trim();

        clearTimeout(debounceTimer);

        if (keyword.length === 0) {
            results.style.display = "none";
            results.innerHTML = "";
            return;
        }

        debounceTimer = setTimeout(() => {
            loadSuggestions(keyword);
        }, 300);
    });

    function loadSuggestions(keyword) {
        fetch("product-suggestions?q=" + encodeURIComponent(keyword))
            .then(response => response.json())
            .then(data => {
                showSuggestions(data);
            })
            .catch(error => console.error("Error fetching product suggestions:", error));
    }

    function showSuggestions(products) {
        results.innerHTML = "";

        if (products.length === 0) {
            results.style.display = "none";
            return;
        }

        console.log(products)
        products.forEach(product => {
            const item = document.createElement("a");
            item.className = "list-group-item list-group-item-action d-flex align-items-center justify-content-between py-2";
            item.href = "product-view?id=" + product.id;

            const safeTitle = document.createTextNode(product.title);
            const contentWrapper = document.createElement("div");
            contentWrapper.className = "d-flex align-items-center";

            const imgUrl = product.image
                ? 'product-image?path=' + product.image
                : 'product-image?path=products/placeholder.jpg';

            const img = document.createElement("img");
            img.src = imgUrl;
            img.width = 40;
            img.height = 40;
            img.className = "rounded me-2 border object-fit-contain";
            img.alt = product.title;

            img.onerror = function() {
                this.src = 'product-image?path=products/placeholder.jpg';
            };

            const textSpan = document.createElement("span");
            textSpan.className = "small fw-medium text-dark";
            textSpan.appendChild(safeTitle);

            contentWrapper.appendChild(img);
            contentWrapper.appendChild(textSpan);
            item.appendChild(contentWrapper);
            results.appendChild(item);
        });

        results.style.display = "block";
    }

    document.addEventListener("click", function (e) {
        if (!searchBox.contains(e.target) && !results.contains(e.target)) {
            results.style.display = "none";
        }
    });
})();