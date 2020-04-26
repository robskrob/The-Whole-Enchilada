import fetch from "unfetch";

export function fetchWithCSRF(url, options = {}) {
  options.headers || (options.headers = {});

  const token = csrfToken();
  if (token) {
    options.headers["X-CSRF-Token"] = token;
  }

  return fetch(url, options);
}


export function postJson(uri, data, callback) {
  let xhttp = new XMLHttpRequest();
  let csrfToken = document.querySelector('meta[name="csrf-token"]').content;
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      if (this.responseText !== "null") {
        callback(JSON.parse(this.responseText));
      }
    }
  };
  if (uri.indexOf("http") != -1) {
    let location = window.location;
    let baseUrl = `${location.protocol}//${location.hostname}`;
    if (location.port.length == 4) baseUrl = `${baseUrl}:${location.port}`;
    uri = `${baseUrl}${uri}`;
  }
  xhttp.open("POST", uri, true);
  xhttp.setRequestHeader("X-CSRF-Token", csrfToken);
  xhttp.setRequestHeader("Content-Type", "application/json");
  xhttp.send(JSON.stringify(data));
}


export function patchJson(uri, data, callback) {
  let xhttp = new XMLHttpRequest();
  let csrfToken = document.querySelector('meta[name="csrf-token"]').content;
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      if (this.responseText !== "null") {
        callback(JSON.parse(this.responseText));
      }
    }
  };
  if (uri.indexOf("http") != -1) {
    let location = window.location;
    let baseUrl = `${location.protocol}//${location.hostname}`;
    if (location.port.length == 4) baseUrl = `${baseUrl}:${location.port}`;
    uri = `${baseUrl}${uri}`;
  }
  xhttp.open("PATCH", uri, true);
  xhttp.setRequestHeader("X-CSRF-Token", csrfToken);
  xhttp.setRequestHeader("Content-Type", "application/json");
  xhttp.send(JSON.stringify(data));
}

export function getRequest(uri, callback) {
  let oReq = new XMLHttpRequest();
  oReq.addEventListener("load", callback);
  oReq.open("GET", uri);
  oReq.send();
}
