let timeout = null
onmessage = (event) => {
  clearTimeout(timeout)
  timeout = setTimeout(() => { postMessage({}) }, 1000)
}
