const $ = document.querySelector.bind(document);
const $$ = document.querySelectorAll.bind(document);

const tabs = $$(".tabs__item");
const panes = $$(".order-list__tab");

const tabActive = $(".tabs__item.tabs__item--active");

tabs.forEach((tab, index) => {
    const pane = panes[index];
    tab.onclick = function () {
        $(".tabs__item.tabs__item--active").classList.remove("tabs__item--active");
        $(".order-list__tab.order-list__tab--active").classList.remove("order-list__tab--active");

        this.classList.add("tabs__item--active");
        pane.classList.add("order-list__tab--active");
    };
});