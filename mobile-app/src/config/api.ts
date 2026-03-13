import axios from "axios";

const api = axios.create({
  baseURL: "http://localhost/api/",
  timeout: 10000,
});

export default api;