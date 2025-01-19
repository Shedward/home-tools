async function validate_response(response) {
    if (response.status != 200) {
        const body = await response.json();
        const bodyString = JSON.stringify(body);
        alert(`Request failed:\n${bodyString}`);
    }
}

async function a_fetch(path, params) {
    let url = path;

    // Convert query
    if (params.query) {
        url += "?" + new URLSearchParams(params.query);
    }

    var fetchParams = params;

    // Convert headers
    const defaultHeaders = {
        "Content-Type": "application/json",
    };
    if (params.headers) {
        fetchParams.headers = Object.assign(defaultHeaders, params.headers);
    } else {
        fetchParams.headers = defaultHeaders;
    }

    // Convert body
    if (params.body) {
        fetchParams.body = JSON.stringify(params.body);
    }

    let response = await fetch(url, fetchParams);
    await validate_response(response);
    return response;
}

export { a_fetch };
