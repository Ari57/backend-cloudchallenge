var counterContainer = document.querySelector(".website-counter")

async function GetCounter() {
    let response = await fetch("https://countertrigger.azurewebsites.net/api/http_trigger")
    let counter = await response.json()
    return counter;
}
GetCounter().then(counter => counterContainer.innerHTML = counter)
