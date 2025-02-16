import SwiftUI

struct FallingSandView: View {
    @State private var particles: [Particle] = []

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            // Draw particles
            Canvas { context, size in
                for particle in particles {
                    context.fill(
                        Path(ellipseIn: CGRect(x: particle.x, y: particle.y, width: 4, height: 4)),
                        with: .color(.yellow)
                    )
                }
            }
        }
        .onAppear {
            startSandfall(size: UIScreen.main.bounds.size)
        }
    }

    // Start the sandfall simulation
    func startSandfall(size: CGSize) {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            // Add new particles at random horizontal positions
            particles.append(Particle(x: CGFloat.random(in: 0...size.width), y: 0))

            // Update particle positions
            for index in particles.indices {
                // Apply gravity
                particles[index].y += 1

                // Collision detection: Stop falling if a particle reaches another particle or the bottom
                if particles[index].y >= size.height - 4 || particles.contains(where: { $0.x == particles[index].x && $0.y == particles[index].y + 4 }) {
                    particles[index].y -= 1
                }
            }

            // Remove particles that fall off the screen
            particles.removeAll { $0.y > size.height }
        }
    }
}

// Particle model
struct Particle {
    var x: CGFloat
    var y: CGFloat
}

//struct FallingSandView_Previews: PreviewProvider {
//    static var previews: some View {
////        FallingSandView()
//    }
//}
