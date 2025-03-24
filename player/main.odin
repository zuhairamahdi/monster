package player
import "core:fmt"
import rl "vendor:raylib"

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