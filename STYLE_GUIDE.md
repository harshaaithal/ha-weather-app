# STYLE_GUIDE.md

---

# Weather-Driven Colors & Visuals

## Sunny / Clear Day
- **Gradient**: #0288D1 → #03A9F4 (bright blue)
- **Particles**: None or subtle light rays
- **Landmark Lighting**: Bright, warm shadows
- **Mood**: Optimistic, energetic

## Rainy
- **Gradient**: #1E3A5F → #2D5A87 (deep navy)
- **Particles**: White rain streaks, 45° angle, varying speeds
- **Landmark Lighting**: Muted, wet reflections
- **Mood**: Calm, cozy

## Thunderstorm
- **Gradient**: #1A1A2E → #2D3436 (dark charcoal)
- **Particles**: Heavy rain + periodic lightning flash (full screen white at 10% opacity, 100ms)
- **Landmark Lighting**: Dramatic, silhouette with lightning illumination
- **Mood**: Intense, dramatic
- **Special**: Screen flash effect on lightning, subtle rumble haptic

## Drizzle / Light Rain
- **Gradient**: #4A6FA5 → #6B8CBE (soft steel blue)
- **Particles**: Gentle sparse rain, slower than heavy rain
- **Landmark Lighting**: Soft diffused light
- **Mood**: Peaceful, contemplative

## Cloudy / Overcast
- **Gradient**: #5E35B1 → #7C4DFF (muted purple)
- **Particles**: Slow drifting fog wisps (optional)
- **Landmark Lighting**: Flat, even lighting
- **Mood**: Neutral, subdued

## Partly Cloudy
- **Gradient**: #4FC3F7 → #81D4FA (light sky blue)
- **Particles**: Slow-moving cloud shadows across screen
- **Landmark Lighting**: Dappled sun/shadow
- **Mood**: Pleasant, mild

## Snowy
- **Gradient**: #E3F2FD → #BBDEFB (icy white-blue)
- **Particles**: Soft white circles (4-8px), gentle drift with horizontal sway
- **Landmark Lighting**: Bright, high contrast, snow-covered
- **Mood**: Quiet, serene, magical
- **Special**: Accumulation effect on landmark base

## Blizzard / Heavy Snow
- **Gradient**: #CFD8DC → #90A4AE (white-gray)
- **Particles**: Dense snow, diagonal movement, reduced visibility
- **Landmark Lighting**: Barely visible, silhouette
- **Mood**: Harsh, intense
- **Special**: Screen shake subtle effect

## Foggy / Misty
- **Gradient**: #B0BEC5 → #CFD8DC (soft gray)
- **Particles**: Layered fog planes moving at different speeds (parallax)
- **Landmark Lighting**: Faded, low contrast, mysterious
- **Mood**: Mysterious, ethereal
- **Special**: Landmark fades in/out with fog density

## Windy
- **Gradient**: #64B5F6 → #90CAF9 (breezy blue)
- **Particles**: Horizontal leaves/debris, speed lines, dust
- **Landmark Lighting**: Normal with motion blur suggestion
- **Mood**: Dynamic, energetic
- **Special**: Landmark slight sway animation, trees bend

## Sunrise / Dawn
- **Gradient**: #FF8A65 → #FFB74D → #64B5F6 (orange-gold-blue, 3-stop)
- **Particles**: Soft golden light rays from horizon
- **Landmark Lighting**: Warm rim lighting, long shadows
- **Mood**: Hopeful, fresh, new beginnings

## Sunset / Dusk
- **Gradient**: #FF7043 → #CE93D8 → #5C6BC0 (orange-pink-purple, 3-stop)
- **Particles**: Warm haze, floating dust motes catching light
- **Landmark Lighting**: Golden hour glow, silhouette option
- **Mood**: Romantic, peaceful, reflective

## Clear Night
- **Gradient**: #1A1A2E → #16213E (deep navy-black)
- **Particles**: Twinkling stars (random opacity pulse), occasional shooting star
- **Landmark Lighting**: Moonlit, cool blue tones, window lights on
- **Mood**: Calm, peaceful, dreamy
- **Special**: Moon phase indicator, constellation hints

## Cloudy Night
- **Gradient**: #263238 → #37474F (charcoal)
- **Particles**: Slow-moving dark cloud layers
- **Landmark Lighting**: Dim, city glow reflection on clouds
- **Mood**: Urban, moody

## Extreme Heat / Heatwave
- **Gradient**: #FF6F00 → #FF8F00 (intense orange)
- **Particles**: Heat shimmer/distortion effect, rising heat waves
- **Landmark Lighting**: Harsh, bleached, high contrast shadows
- **Mood**: Intense, warning
- **Special**: Subtle screen waviness distortion

## Extreme Cold / Freezing
- **Gradient**: #E1F5FE → #B3E5FC (pale icy blue)
- **Particles**: Ice crystals forming on screen edges, breath vapor
- **Landmark Lighting**: Stark, crisp, frozen
- **Mood**: Harsh, biting
- **Special**: Frost creep animation on screen corners

## Haze / Smog
- **Gradient**: #A1887F → #BCAAA4 (brownish gray)
- **Particles**: Thick particulate layer, reduced saturation
- **Landmark Lighting**: Washed out, low visibility
- **Mood**: Unhealthy, warning
- **Special**: AQI indicator prominent

## Sandstorm / Dust Storm
- **Gradient**: #D7CCC8 → #A1887F (tan-brown)
- **Particles**: Dense horizontal sand/dust particles, varying sizes
- **Landmark Lighting**: Obscured, sepia tone
- **Mood**: Harsh, dramatic
- **Special**: Screen visibility pulses with wind gusts

## After Rain (Rainbow)
- **Gradient**: #4FC3F7 → #81D4FA (clearing blue)
- **Particles**: Residual droplets, rainbow arc overlay
- **Landmark Lighting**: Wet surfaces, reflections, fresh
- **Mood**: Refreshed, optimistic
- **Special**: Rainbow appears as rewarding moment

## Sleet / Freezing Rain
- **Gradient**: #78909C → #90A4AE (cold gray-blue)
- **Particles**: Mix of rain streaks and ice pellets (white dots faster than snow)
- **Landmark Lighting**: Icy reflections, glazed surfaces
- **Mood**: Uncomfortable, hazardous

## Hail
- **Gradient**: #546E7A → #78909C (dark steel)
- **Particles**: White/ice balls falling fast, bouncing effect
- **Landmark Lighting**: Dramatic, storm lighting
- **Mood**: Dangerous, intense
- **Special**: Impact animations on landmark

---

# Typography

| Element | Size | Weight | Notes |
|---------|------|--------|-------|
| Temperature | 72px | Bold (700) | Main focus |
| City Name | 20px | Semibold (600) | Top left |
| Date/Time | 14px | Regular (400) | 70% opacity |
| Weather Labels | 14px | Regular (400) | Muted |
| Weather Values | 18px | Semibold (600) | Full white |

**Font Families**
- iOS: SF Pro Display
- Android: Google Sans (or Inter as fallback)

---

# Spacing

- Screen padding: 24px horizontal
- Card border radius: 32px (if using cards)
- Stats grid gap: 16px
- Section spacing: 32px
- Bottom safe area: 34px (for notch devices)

---

# 3D Landmarks

- **Style**: Isometric, low-poly, soft shadows
- **Platform Base**: Circular gradient (#000 at 20% opacity)
- **Animation**: Subtle float (2px up/down, 3s loop, ease-in-out)
- **Creation Pipeline**: Blender → Rive/Lottie export
- **Size**: ~200x200dp centered

---

# Weather Particles Reference

| Weather | Shape | Movement | Speed | Opacity |
|---------|-------|----------|-------|---------|
| Rain | Streaks 2x20px | 45° diagonal | 200-400ms | 60-80% |
| Heavy Rain | Streaks 2x30px | 60° diagonal | 100-200ms | 70-90% |
| Snow | Circles 4-8px | Vertical + sway | 800-1200ms | 70-90% |
| Blizzard | Circles 3-6px | 30° diagonal | 400-600ms | 50-70% |
| Hail | Circles 8-12px | Vertical fast | 150-250ms | 90% |
| Fog | Planes/layers | Horizontal slow | 5000-8000ms | 30-50% |
| Dust | Specs 2-4px | Horizontal fast | 300-500ms | 40-60% |
| Stars | Dots 1-3px | Static twinkle | N/A | 50-100% pulse |

---

# Weather Stats Grid

- **Layout**: 2x2 grid
- **Icon Style**: Line icons, 1.5px stroke, white
- **Labels**: 70% opacity white
- **Values**: 100% white, semibold

**Primary Stats**
1. Feels like (°C)
2. Wind (km/h)
3. Precipitation (%)
4. Humidity (%)

**Optional Extras**
- Chance of rain
- UV Index
- Visibility
- Pressure
- AQI (Air Quality)

---

# Animations

| Element | Animation | Duration | Easing |
|---------|-----------|----------|--------|
| Page transition | Shared element morph | 300ms | ease-out |
| Background gradient | Color shift | 500ms | ease-in-out |
| Landmark | Float loop | 3000ms | ease-in-out |
| Pull to refresh | Landmark spin | 600ms | spring |
| Stats appear | Fade + slide up | 200ms | ease-out |
| Lightning flash | Opacity pulse | 100ms | linear |
| Star twinkle | Opacity random | 1000-3000ms | ease-in-out |

---

# Do's and Don'ts

**Do**
- Use weather to drive the entire color scheme
- Keep data density low
- Make temperature the hero element
- Use animations purposefully
- Maintain generous whitespace
- Add haptic feedback for weather events
- Consider accessibility (color blind modes)

**Don't**
- Use default Material/Cupertino widgets
- Add unnecessary UI chrome
- Use static PNG icons
- Clutter with too many stats
- Use sharp corners
- Overdo animations (battery drain)
- Ignore reduced motion preferences
