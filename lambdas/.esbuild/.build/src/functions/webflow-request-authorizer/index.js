"use strict";
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// src/functions/webflow-request-authorizer/index.ts
var webflow_request_authorizer_exports = {};
__export(webflow_request_authorizer_exports, {
  handler: () => handler
});
module.exports = __toCommonJS(webflow_request_authorizer_exports);
var handler = async (event) => {
  const headers = event.headers;
  if (!headers)
    return {
      isAuthorized: false,
      context: {
        statusCode: 401,
        body: "No credentials"
      }
    };
  const userId = headers["user-id"];
  const requestToken = headers["request-token"];
  if (!userId || !requestToken)
    return {
      isAuthorized: false,
      context: {
        statusCode: 401,
        body: "No credentials"
      }
    };
  const webflowAuthToken = process.env.WEBFLOW_AUTH_TOKEN;
  const siteId = process.env.SITE_ID;
  const userResponse = await fetch(`https://api.webflow.com/sites/${siteId}/users/${userId}`, {
    method: "GET",
    headers: {
      "accept": "application/json",
      "authorization": `Bearer ${webflowAuthToken}`
    }
  });
  const user = await userResponse.json();
  const token = user.data["session-token"];
  if (requestToken !== token)
    return {
      isAuthorized: false,
      context: {
        statusCode: 403,
        body: "Wrong credentials"
      }
    };
  return {
    isAuthorized: true,
    context: {
      statusCode: 200,
      body: "Success"
    }
  };
};
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  handler
});
