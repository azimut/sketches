import random
import pygame
import math

fps      = 60
ventanaV = 800
ventanaH = round(ventanaV * 0.8)
negro    = (10,10,10)
blanco   = (255,255,255)
rojo     = (255, 0, 0)
amarillo = (255, 255, 0)

class Spawner:
    def __init__(self):
        self.queue = [(Borracho, lambda: 5, lambda: random.randint(0,ventanaH-60), lambda: -50),
                      (Firme   , lambda: 3, lambda: random.randint(0,ventanaH-60), lambda: -50),
                      (Sideway , lambda: 3, lambda: -50                          , lambda: random.randint(0,ventanaH//4))]
        self.queue_index = 0
        self.spawn = []
        self.waiting = False
        self.contador = 0
        self.currentx = self.queue[self.queue_index][2]()
        self.currenty = self.queue[self.queue_index][3]()
        self.currentcolor = (random.randint(0,254), random.randint(0,254), random.randint(0,254))
    def alivep(self):
        for spawn in self.spawn:
            if spawn.life > 0:
                return True
        return False
    def breed(self):
        if self.waiting and self.alivep():
            return
        if self.waiting and not self.alivep():
            self.spawn = []
            self.waiting = False
        # spawn one, every nth seconds, until 10 spawned, then wait
        size = len(self.spawn)
        if size < 5:
            self.contador += 1
            if self.contador == 25:
                self.contador = 0
                self.spawn.append(self.queue[self.queue_index][0](self.currentx, self.currenty))
        elif size == 5:
            self.queue_index = (self.queue_index + 1) % len(self.queue)
            self.currentx = self.queue[self.queue_index][2]()
            self.currenty = self.queue[self.queue_index][3]()
            self.waiting = True
    def choca_con(self, otro):
        for spawn in self.spawn:
            if spawn.choca_con(otro):
                return True
        return False
    def mover(self, accel):
        for spawn in self.spawn:
            spawn.mover(accel)
    def mostrar(self, ventana):
        for spawn in self.spawn:
            spawn.mostrar(ventana)

class Planeta:
    def __init__(self):
        self.original = pygame.image.load("imagenes/planeta.png").convert_alpha()
        self.ancho, self.alto = self.original.get_size()
        self.imagen = pygame.Surface((self.ancho, self.alto), pygame.SRCALPHA)
        self.reiniciar()
    def reiniciar(self):
        self.color = (random.randint(1,255),random.randint(1,255),random.randint(1,255))
        self.scala = random.randint(1,5)
        self.x = random.randint(-self.ancho//2, self.ancho//2)
        self.y = -self.alto*self.scala*2
        self.imagen.blit(self.original, (0,0))
        self.imagen.fill(self.color, special_flags=pygame.BLEND_MULT)
    def mover(self, accel, _estado):
        self.y += 1 + accel*0.2
        if self.y > ventanaV*2:
            self.reiniciar()
    def mostrar(self, ventana):
        ventana.blit(pygame.transform.scale_by(self.imagen, (self.scala,self.scala)), (self.x, self.y))


class Sprite:
    def __init__(self, ruta, cols):
        self.imagen = pygame.image.load(ruta)
        self.ancho, self.alto = self.imagen.get_size()
        self.cols = cols
        self.recorte = pygame.Surface((self.ancho//self.cols, self.alto), pygame.SRCALPHA)
        self.cuadro = 0
        self.x = 0
        self.y = -ventanaV
        self.contador = 0
        self.termino = False
    def reiniciar(self):
        self.cuadro = 0
        self.x = 0
        self.y = -ventanaV
        self.contador = 0
        self.termino = False
    def animar(self):
        if self.termino:
            return
        self.contador += 1
        if self.contador > 10:
            self.contador = 0
            self.cuadro = (self.cuadro + 1) % self.cols
        if self.cuadro == self.cols - 1:
            self.termino = True
            self.y = -10
    def mostrar(self, ventana):
        if self.y < 0:
            return
        self.recorte.fill((0,0,0,0))
        self.recorte.blit(self.imagen,(0,0),(self.ancho / self.cols * self.cuadro, 0, self.ancho//self.cols, self.alto))
        ventana.blit(self.recorte, (self.x,self.y))

class Explosion(Sprite):
    def __init__(self):
        super().__init__("imagenes/explosion.png", 6)


class Titulo:
    def __init__(self):
        self.font = pygame.font.Font(None, 200)
        self.imagen = self.font.render("Galaga", False, blanco)
        self.ancho, self.alto = self.imagen.get_size()

        self.colores = [(255,255,255),(10,10,10)]
        self.parpadeo_indice = 0
        self.font_start = pygame.font.Font(None, 40)
        self.imagen_start = self.font_start.render("Pulse Espacio", False, blanco)
        self.ancho_start, self.alto_start = self.imagen_start.get_size()

        self.sonido_empezar = pygame.mixer.Sound("sonidos/empezar.ogg")

    def parpadear(self):
        self.parpadeo_indice = (self.parpadeo_indice + 1) % 100
        self.imagen_start = self.font_start.render("Pulse Espacio", False, self.colores[self.parpadeo_indice  % 2])
        self.ancho_start, self.alto_start = self.imagen_start.get_size()

    def mostrar(self, ventana):
        ventana.blit(pygame.transform.scale_by(self.imagen, (1,2)),
                     (ventanaH/2 - self.ancho/2,
                      ventanaV/2 - self.alto))
        ventana.blit(self.imagen_start, (ventanaH/2 - self.ancho_start/2,
                                         ventanaV*0.75 - self.alto_start/2))


class Resultado:
    def __init__(self):
        self.font = pygame.font.Font(None, 85)
        self.perdio()
    def perdio(self):
        self.imagen = self.font.render("PERDISTE", False, rojo)
        self.ancho, self.alto = self.imagen.get_size()
    def gano(self):
        self.imagen = self.font.render("GANASTE", False, amarillo)
        self.ancho, self.alto = self.imagen.get_size()
    def mostrar(self, ventana):
        ventana.blit(pygame.transform.scale_by(self.imagen, (1,3)), (ventanaH/2 - self.ancho/2, ventanaV/2 - self.alto))

class Chocador:
    def choca_con(self, otro): # otro.ancho otro.alto otro.x otro.y
        if self.y < 0 or otro.y < 0:
            return False
        xc_self = self.x + self.ancho/2
        yc_self = self.y + self.ancho/2
        r_self = self.ancho/2
        xc_otro = otro.x + otro.ancho/2
        yc_otro = otro.y + otro.alto/2
        r_otro = otro.ancho/2
        distancia = math.sqrt( (xc_otro - xc_self)**2 + (yc_otro - yc_self)**2)
        distancia_bordes = distancia - (r_self + r_otro)
        return distancia_bordes <= 0

class Item(Chocador):
    def __init__(self):
        self.ancho = 20
        self.alto = 20
        self.x = random.randint(0, ventanaH - self.ancho)
        self.y = -self.alto
    def mostrar(self, ventana):
        pygame.draw.rect(ventana, (0,0,255), (self.x, self.y, self.ancho, self.alto))
    def mover(self):
        self.y -= 1

class Puntaje:
    def __init__(self):
        self.puntaje = 0
        self.font = pygame.font.Font(None, 35)
        self.imagen = self.font.render(str(self.puntaje), False, blanco)
        self.ancho, self.alto = self.imagen.get_size()
    def reiniciar(self):
        self.puntaje = 0
    def puntuar(self, puntaje):
        self.puntaje += puntaje
        self.imagen = self.font.render(str(self.puntaje), False, blanco)
        self.ancho, self.alto = self.imagen.get_size()
    def mostrar(self, ventana):
        ventana.blit(self.imagen, (ventanaH - self.ancho - 10, ventanaV - self.alto - 10))

class Enemigo(Chocador):
    def __init__(self, x, y):
        self.image = pygame.image.load("imagenes/enemigo.png")
        self.ancho, self.alto = self.image.get_size()
        self.x = x # random.randint(0,ventanaH-self.ancho)
        self.y = y # -self.alto;
        self.explosion = Explosion()
        self.life = 1
    def choca_con(self, otro):
        choco = super().choca_con(otro)
        if choco:
            self.y = ventanaV
            self.explotar()
            self.life -= 1
        return choco
    def explotar(self):
        self.explosion.reiniciar()
        self.explosion.x = self.x
        self.explosion.y = self.y
    def mostrar(self, ventana):
        if not self.explosion.termino:
            self.explosion.animar()
            self.explosion.mostrar(ventana)
        ventana.blit(self.image, (self.x,self.y))
    def mover(self, accel):
        self.y += 2 + accel
        self.x += math.sin(self.y*0.02) * 3
        self.x = min(max(self.x, 0), ventanaH - self.ancho)
        if self.y > ventanaV:
            #self.respawn()
            self.life = 0
    def respawn(self):
        self.y = -self.alto
        self.x = random.randint(0,ventanaH-self.ancho)

class Borracho(Enemigo):
    def mover(self, accel):
        self.y += 2 + accel
        self.x += math.sin(self.y*0.02) * 2
        self.x = min(max(self.x, 0), ventanaH - self.ancho)
        if self.y > ventanaV:
            #self.respawn()
            self.life = 0

class Firme(Enemigo):
    def mover(self, accel):
        self.y += 2 + accel
        if self.y > ventanaV:
            #self.respawn()
            self.life = 0

class Sideway(Enemigo):
    def mover(self, _accel):
        self.x += 2
        if self.x > ventanaH:
            #self.respawn()
            self.life = 0

class Misil:
    def __init__(self):
        self.image = pygame.image.load("imagenes/misil.png").convert_alpha()
        self.ancho, self.alto = self.image.get_size()
        self.x = -1
        self.y = -ventanaV
    def mover(self):
        if self.y >= 0:
            self.y -= 4
    def mostrar(self, ventana):
        if     self.x > 0 \
           and self.x < ventanaH \
           and self.y > 0 \
           and self.y < ventanaV:
            ventana.blit(self.image, (self.x,self.y))
    def disparar(self, x, y):
        self.x = x
        self.y = y


class Nave:
    def __init__(self):
        self.imagen = pygame.image.load("imagenes/nave.png")
        self.imagen_izq = pygame.image.load("imagenes/nave_izq.png")
        self.imagen_der = pygame.image.load("imagenes/nave_der.png")
        self.imagen_vida = pygame.image.load("imagenes/vida.png")
        self.imagen_vida_ancho, self.imagen_vida_alto = self.imagen_vida.get_size()
        self.ancho, self.alto = self.imagen.get_size()
        self.sonido_misil = pygame.mixer.Sound("sonidos/misil.ogg")
        self.sonido_misil.set_volume(0.1)
        self.sonido_boom = pygame.mixer.Sound("sonidos/boom.ogg")
        self.sonido_crash = pygame.mixer.Sound("sonidos/crash.ogg")
        self.reiniciar()
    def reiniciar(self):
        self.x = ventanaH/2
        self.y = ventanaV - self.alto - 20
        self.velx = 0
        self.vely = 0
        self.accel = 0
        self.salud = 3
        self.misiles = [Misil() for i in range(28)]
        self.disparo_delay = 0
        self.disparando = False
        self.estado = 0 # 0 idle / 1 izquierda / 2 derecha
    def izquierda(self):
        self.estado = 1
    def derecha(self):
        self.estado = 2
    def golpear(self):
        self.salud -= 1
    def muerta(self):
        return self.salud == 0
    def mostrar(self, ventana):
        margen_vida = 10
        for i in range(self.salud):
            ventana.blit(self.imagen_vida,
                         (i * self.imagen_vida_ancho + margen_vida * i + margen_vida,
                          ventanaV - self.imagen_vida_alto - margen_vida))
        for misil in self.misiles:
            misil.mostrar(ventana)
        if self.estado == 0:
            ventana.blit(self.imagen, (self.x, self.y))
        elif self.estado == 1:
            ventana.blit(self.imagen_izq, (self.x, self.y))
        elif self.estado == 2:
            ventana.blit(self.imagen_der, (self.x, self.y))
    def mover(self):
        if self.disparando:
            self.disparo_delay -= 1
            if self.disparo_delay < 0:
                self.disparo_delay = fps / 10
                for misil in self.misiles:
                    if misil.y < 0:
                        self.sonido_misil.play()
                        misil.y = self.y - misil.alto
                        misil.x = self.x + self.ancho/2 - misil.ancho/2
                        break
        if self.estado == 1:
            self.x -= 7
        elif self.estado == 2:
            self.x += 7
        self.y += self.vely
        self.x = min(max(self.x, 0), ventanaH - self.ancho)
        self.y = min(max(self.y, ventanaV/2), ventanaV - self.alto)
        for misil in self.misiles:
            misil.mover()
    def pausa(self):
        self.disparando = False
    def disparar(self, ventana):
        self.disparando = True


class Estrella:
    def __init__(self):
        self.x = random.randint(0,ventanaH)
        self.y = random.randint(0,ventanaV)
        self.size = random.randint(0, 4)
        self.accel = 0
        self.contador = random.randint(400,900)
    def mostrar(self, ventana):
        color = blanco
        if self.contador < 0:
            color = negro
        if self.contador < -fps:
            self.contador = random.randint(400,900)
        pygame.draw.rect(ventana, color, (self.x,self.y,self.size, self.size + self.accel))
    def mover(self, accel, estado):
        self.contador -= 1
        self.accel = accel
        if estado == 1:
            self.x = (self.x + 1*self.size*.2) % ventanaH
        elif estado == 2:
            self.x = (self.x - 1*self.size*.2) % ventanaH
        self.y = ((self.y + 2*self.size*.2)+self.accel) % ventanaV
        if self.x == 0 or self.y == 0:
            self.size = random.randint(1,4)

class Estrellas:
    def __init__(self, cantidad):
        self.universo = [Estrella() for i in range(cantidad)]
        self.universo.append(Planeta())
    def mostrar(self, ventana):
        for estrella in self.universo:
            estrella.mostrar(ventana)
    def mover(self, accel, estado):
        for estrella in self.universo:
            estrella.mover(accel, estado)


def main():
    pygame.init()
    pygame.mixer.init()
    ventana = pygame.display.set_mode((ventanaH,ventanaV))
    estrellas = Estrellas(200)
    nave = Nave()
    jugando = True
    puntaje = Puntaje()
    titulo = Titulo()
    resultado = Resultado()
    estado = 0
    spawner = Spawner()
    while jugando:
        ventana.fill(negro)
        estrellas.mostrar(ventana)
        estrellas.mover(nave.accel, nave.estado)
        if estado == 0:
            nave.reiniciar()
            puntaje.reiniciar()
            titulo.mostrar(ventana)
            titulo.parpadear()
            for event in pygame.event.get():
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_SPACE:
                        titulo.sonido_empezar.play()
                        estado = 5
                if event.type == pygame.QUIT:
                    jugando = False
        elif estado == 1:
            resultado.mostrar(ventana)
            for event in pygame.event.get():
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_SPACE:
                        estado = 0
                        nave.reiniciar()
                if event.type == pygame.QUIT:
                    jugando = False
        elif estado == 2:
            resultado.mostrar(ventana)
            for event in pygame.event.get():
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_SPACE:
                        estado = 0
                if event.type == pygame.QUIT:
                    jugando = False
        else:
            nave.mostrar(ventana)
            nave.mover()
            spawner.mostrar(ventana)
            spawner.breed()
            spawner.mover(nave.accel)
            puntaje.mostrar(ventana)
            puntaje.puntuar(1)
            if spawner.choca_con(nave):
                nave.golpear()
                nave.sonido_crash.play()
            if nave.muerta():
                estado = 2
            for misil in nave.misiles:
                if spawner.choca_con(misil):
                    misil.y = -ventanaV
                    puntaje.puntuar(1000)
                    nave.sonido_boom.play()
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    jugando = False
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_SPACE:
                        nave.disparar(ventana)
                    if event.key == pygame.K_j:
                        nave.izquierda()
                    if event.key == pygame.K_l:
                        nave.derecha()
                    if event.key == pygame.K_k:
                        nave.vely += 6
                    if event.key == pygame.K_i:
                        nave.vely -= 3
                        for estrella in estrellas.universo:
                            nave.accel = 5
                if event.type == pygame.KEYUP:
                    if event.key == pygame.K_i:
                        nave.vely = 0
                        for estrella in estrellas.universo:
                            nave.accel = 0
                    if event.key == pygame.K_k:
                        nave.vely = 0
                    if event.key == pygame.K_j:
                        nave.estado = 0
                    if event.key == pygame.K_l:
                        nave.estado = 0
                    if event.key == pygame.K_SPACE:
                        nave.pausa()


        pygame.display.flip()
        pygame.time.Clock().tick(fps)

if __name__ == '__main__':
    main()
