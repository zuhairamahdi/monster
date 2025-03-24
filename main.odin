package main

import "core:fmt"
import rl "vendor:raylib"


SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450
PlayerDirection :: enum {
    RIGHT,
    LEFT,
    UP,
    DOWN
}
Player :: struct {
    position: rl.Vector2,
    speed: f32,
    color: rl.Color,
    direction: PlayerDirection,
    is_moving: bool

}

move_player :: proc(player: ^Player) {
    player.is_moving = false
    if rl.IsKeyDown(.RIGHT) {
        player.position.x += player.speed
        player.direction = .RIGHT
        player.is_moving = true
    }else if rl.IsKeyDown(.LEFT) {
        player.position.x -= player.speed
        player.direction = .LEFT
        player.is_moving = true
    } else if rl.IsKeyDown(.UP) {
        player.position.y -= player.speed
        player.direction = .UP
        player.is_moving = true
    }else if rl.IsKeyDown(.DOWN) {
        player.position.y += player.speed
        player.direction = .DOWN
        player.is_moving = true
    }
}
main :: proc() {
    rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "monster game")
    player_spritesheet := rl.LoadTexture("assets/player.png")
    player_frames := []rl.Texture2D{
        rl.LoadTexture("assets/player/main/down0.png"),
        rl.LoadTexture("assets/player/main/down1.png"),
        rl.LoadTexture("assets/player/main/right0.png"),
        rl.LoadTexture("assets/player/main/right1.png"),
        rl.LoadTexture("assets/player/main/up0.png"),
        rl.LoadTexture("assets/player/main/up1.png"),
        rl.LoadTexture("assets/player/main/left0.png"),
        rl.LoadTexture("assets/player/main/left1.png"),
    }
    rl.SetTargetFPS(60)
    player := Player{rl.Vector2{50, 50}, 1.0, rl.RED, .DOWN, false}
    frameWidth := 16
    frameHeight := 16
    numFrames := 2
    frameDuration := 0.15 // Duration of each frame in seconds
    currentFrame := 0
    frameTime := 0.0

    for rl.WindowShouldClose() == false {
        move_player(&player)
        rl.BeginDrawing()
        frameTime += f64(rl.GetFrameTime())

        if player.is_moving && f32(frameTime) >= f32(frameDuration) {
            frameTime = 0.0
            currentFrame = (currentFrame + 1) % numFrames
            if player.direction == .RIGHT {
                currentFrame = 2 + currentFrame
            } 
            if player.direction == .UP {
                currentFrame = 4 + currentFrame
            }
            if player.direction == .LEFT {
                currentFrame = 6 + currentFrame
            }
        
        } else if !player.is_moving {
            currentFrame = 0
            if player.direction == .RIGHT {
                currentFrame = 2
            }
            if player.direction == .UP {
                currentFrame = 4
            }
            if player.direction == .LEFT {
                currentFrame = 6
            }


        }
        rl.ClearBackground(rl.BLACK)
        sourceRec := rl.Rectangle{f32(currentFrame) * f32(frameWidth), 0, f32(frameWidth), f32(frameHeight)}
        scale :f32= 3.5 // Scale factor
        destRec := rl.Rectangle{player.position.x, player.position.y, sourceRec.width * scale, sourceRec.height * scale}
        
        // Define the origin point (usually the center of the sprite)
        origin := rl.Vector2{sourceRec.width * scale / 2, sourceRec.height * scale / 2}

        // Draw the scaled sprite
        // fmt.printfln("current frame: %d", player_frames[currentFrame])
        rl.DrawTexturePro(player_frames[currentFrame], sourceRec, destRec, origin, 0.0, rl.WHITE)

        rl.EndDrawing()
    }
    // rl.UnloadTexture(player_spritesheet)
    rl.CloseWindow()
}