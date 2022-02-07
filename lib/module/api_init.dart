const base = "https://apisetes.herokuapp.com/";
// const base = "http://10.0.2.2:3010/";

const baseApi = base + "mobile/";

setApi(v) => Uri.parse(baseApi + v);

// String eventsWeb = 'https://kalyanibajaj.com/';
String eventsWeb = 'https://setesadmin.herokuapp.com/events/';

String setImgEvent(v) => base + "asset/events/" + v.toString();
String setImgProfile(v) => base + "asset/members/" + v.toString();
String setImgTruf(v, u) =>
    base + "asset/trufs/" + v.toString() + "/" + u.toString();
