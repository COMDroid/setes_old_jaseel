// const base = "http://10.0.2.2:3010/";
const base = "https://18.116.136.111:8000/";
const baseApi = base + "mobile/";

setApi(v) => Uri.parse(baseApi + v);
String eventsWeb = 'https://18.116.136.111/events/';

String setImgEvent(v) => base + "asset/events/" + v.toString();
String setImgProfile(v) => base + "asset/members/" + v.toString();
String setImgUser(v) =>
    "${base}asset/members/" + v['_id'].toString() + '/' + v['img'].toString();
String setImgTruf(v, u) =>
    "${base}asset/trufs/" + v.toString() + "/" + u.toString();


Uri wsUrl(s) => Uri.parse('wss://setes.in:8000/users/' + s);