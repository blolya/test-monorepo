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

// src/functions/cars/index.ts
var cars_exports = {};
__export(cars_exports, {
  handler: () => handler
});
module.exports = __toCommonJS(cars_exports);

// src/libs/math.ts
function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}

// src/functions/cars/index.ts
var handler = async (event) => {
  try {
    const response = {
      statusCode: 200,
      body: "POST a lot of cars/ " + getRandomInt(100) + ` with body ${JSON.stringify(event.body)}`
    };
    return response;
  } catch (err) {
    return {
      statusCode: 500,
      body: "Internal Server Error"
    };
  }
};
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  handler
});
