# Weather App Project Context

## Project Overview
A beautiful Flutter weather app with dynamic gradient backgrounds and 3D city landmarks.

## Key Resources
- **GitHub:** https://github.com/harshaaithal/ha-weather-app
- **Notion Implementation Plan:** https://www.notion.so/2dc6ebcac263818a8b01f951c841dfaa
- **Notion Style Guide:** https://www.notion.so/2dc6ebcac2638104be3fd4713a5ca3ed
- **Notion Tech Stack:** https://www.notion.so/2dc6ebcac26381cb8a28fe8ff04229a9

## Progress Tracking
**IMPORTANT:** After completing any task or phase, update the Notion Implementation Plan page to reflect progress:
- Mark completed items with `[x]`
- Keep the checkboxes in sync with actual implementation
- Use `mcp__notion__notion-update-page` tool to update

## Current Status
- **Phase 0:** COMPLETED (Setup)
- **Phase 1:** NOT STARTED (MVP Core)

## Tech Stack
- Flutter 3.38.5
- State: Riverpod
- Animations: flutter_animate, Rive, Lottie
- API: Open-Meteo (free, no key needed)
- Location: geolocator, geocoding
- Storage: Hive, shared_preferences

## API Strategy
**Current:** Open-Meteo (free, 10k req/day)
- ✅ Current, hourly, daily forecast (16 days)
- ✅ Air Quality, UV Index
- ❌ Minute-by-minute, Weather alerts, Radar

**Architecture:** Repository Pattern for easy API switching
```
WeatherRepository (abstract)
       │
   ┌───┴───┐
   ▼       ▼
OpenMeteo  Tomorrow.io (future)
```

**Upgrade Path:**
- MVP → v1: Open-Meteo (free)
- Pro tier: Add Tomorrow.io/OpenWeather for alerts
- Scale: Cloudflare Worker proxy with caching

**To switch APIs:** Create new service, map to same Weather model, change DI. Effort: 2-4 hours

## Project Structure
```
lib/
├── core/
│   ├── theme/       # Weather gradients, colors
│   ├── constants/   # API endpoints, weather codes
│   └── utils/       # Helpers
├── data/
│   ├── models/      # Weather, Location models
│   ├── repositories/
│   └── services/    # API, location services
└── presentation/
    ├── screens/     # Weather screen, settings
    ├── widgets/     # Stats grid, hourly scroll
    └── providers/   # Riverpod providers
```

## Phase 1 Tasks (Next)
1. Weather Data Layer
   - **Repository pattern** (WeatherRepository abstract class)
   - Open-Meteo API integration (OpenMeteoWeatherService)
   - Location service (GPS + search)
   - Weather model classes (freezed)
   - Riverpod providers

2. Core UI
   - Main weather screen (gradient bg + large temp)
   - Weather-driven gradient backgrounds (5 initial: sunny, rainy, cloudy, night, snow)
   - Stats grid (feels like, wind, humidity, precipitation)
   - Hourly horizontal scroll
   - 7-day forecast list

3. Placeholder Landmark
   - Static isometric placeholder image
   - Float animation (2px, 3s loop)

## Commands
```bash
# Run the app
flutter run

# Generate code (freezed, json_serializable, riverpod)
dart run build_runner build --delete-conflicting-outputs
```
