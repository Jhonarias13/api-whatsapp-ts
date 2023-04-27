import "dotenv/config"
import express from "express"
import cors from "cors"
import routes from "./lead/infrastructure/router"
import path from "path";

const port = process.env.PORT || 3001
const app = express();

app.use(cors());
app.use(express.json())

app.use(express.static(path.join(__dirname, '../public')));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, "../public", 'index.html'))
});

app.use(`/`, routes);

app.listen(port, () => console.log(`✅ Ready http://localhost:${port}`))