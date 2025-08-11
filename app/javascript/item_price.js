const price = () => {
  window.addEventListener('turbo:load', () => {

  });

  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const price = parseFloat(inputValue);

    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    if (!isNaN(price)) {
      const tax = Math.floor(price * 0.1);
      addTaxDom.innerHTML = tax;

      const profit = price - tax;
      profitDom.innerHTML = profit;
    } else {
      addTaxDom.innerHTML = '';
      profitDom.innerHTML = '';
    }
  });

};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);