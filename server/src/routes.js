const router = require("express").Router();
const moment = require("moment");
const _ = require("lodash");

const knex = require("./knex/knex");
const HanhKhachModel = require("./models/HanhKhach.model");
const TuyenXeBusModel = require("./models/TuyenXeBus.model");
const TuyenTauDienModel = require("./models/TuyenTauDien.model");
const GaTramModel = require("./models/GaTram.model");
const ChuyenTauXeModel = require("./models/ChuyenTauXe.model");

router.get("/", (req, res) => {
  res.send("Server is running!!!");
});

router.get("/hanh-khach", async (req, res) => {
  try {
    const all = await HanhKhachModel.findAll();
    return res.json(all);
  } catch (error) {
    console.error(error);
    res.sendStatus(500);
  }
});

router.get("/thong-ke-luot-nguoi", async (req, res) => {
  try {
    const { ma_tuyen, tu_ngay, toi_ngay } = req.query;
    let data = await knex.raw("call ThongKeLuotNguoi(?,?,?);", [
      ma_tuyen,
      tu_ngay,
      toi_ngay,
    ]);
    data = data[0][0].map((row) => {
      row.ngay_su_dung = moment(
        _.trim(JSON.stringify(row.ngay_su_dung), "'\"\\")
      ).format("DD-MM-YYYY");
      return row;
    });
    res.json(data);
  } catch (error) {
    console.error(error);
    res.sendStatus(500);
  }
});

router.get("/tuyen-xe-bus", async (req, res) => {
  try {
    const data = await TuyenXeBusModel.findAll();
    res.json(data);
  } catch (error) {
    console.error(error);
    res.sendStatus(500);
  }
});
router.post("/tuyen-xe-bus", async (req, res) => {
  try {
    const { ma_tuyen } = req.body;
    const data = await TuyenXeBusModel.addTuyenXeBus({ ma_tuyen });
    res.json(data);
  } catch (error) {
    console.error(error);
    res.sendStatus(500);
  }
});

router.get("/tuyen-tau-dien", async (req, res) => {
  try {
    const data = await TuyenTauDienModel.findAll();
    res.json(data);
  } catch (error) {
    console.error(error);
    res.sendStatus(500);
  }
});
router.get("/add-tuyen-tau-dien", async (req, res) => {
  try {
    const { ma_tuyen_tau, ten_tuyen_tau, ma_tuyen_tau_xe } = req.body;
    const data = await TuyenTauDienModel.addTuyenTauDien({
      ma_tuyen_tau,
      ten_tuyen_tau,
      ma_tuyen_tau_xe,
    });
    res.json(data);
  } catch (error) {
    console.error(error);
    res.sendStatus(500);
  }
});

router.get("/ga-tram", async (req, res) => {
  try {
    const data = await GaTramModel.findAll();
    res.json(data);
  } catch (error) {
    console.error(error);
    res.sendStatus(500);
  }
});

router.get("/chuyen-tau-xe", async (req, res) => {
  try {
    const data = await ChuyenTauXeModel.getAllWithGaTram();
    res.json(data);
  } catch (error) {
    console.error(error);
    res.sendStatus(500);
  }
});
router.get("/add-chuyen-tau-xe", async (req, res) => {
  try {
    const {
      ma_tuyen = "B002",
      stt = 3,
      ma_ga_tram = "BT00002",
      stt_ga_tram = 1,
      gio_ghe = "10:10:00",
      gio_di = "10:30:00",
    } = req.body;
    const data = await ChuyenTauXeModel.addChuyenTauXe({
      ma_tuyen,
      stt,
      ma_ga_tram,
      stt_ga_tram,
      gio_ghe,
      gio_di,
    });
    res.json(data);
  } catch (error) {
    console.error(error);
    res.sendStatus(500);
  }
});

module.exports = router;
