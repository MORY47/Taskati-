// Caching
// Caching means saving data for later use so your app doesn’t always need to download or calculate it again.

// we use it 
// 1.to make app faster
// 2. works offline
// 3.saves battery and usage

// caching types in flutter
// 1. in-memory cache : data stored in RAM 
// (like using Map,  provier)
// 2. local storage : data always saved on device
// ( like shared_preferences : for small data
//   hive, sqfile : for larger data,
//   cached_netwrok_image : for saving downloaded images automatically
// ) 


// CachedNetworkImage(
//   imageUrl: "https://example.com/photo.png",
//   placeholder: (context, url) => CircularProgressIndicator(),
//   errorWidget: (context, url, error) => Icon(Icons.error),
// )
// The first time it downloads the image. Next time, it loads from cache (faster, even offline).