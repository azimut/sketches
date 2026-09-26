import random
import pygame
import math

fps      = 60
ventanaH = 700
ventanaV = 700
negro    = (0,0,0)
blanco   = (255,255,255)


class Enemigo:
    def __init__(self):
        self.image = pygame.image.load("imagenes/enemigo.png")
        self.ancho, self.alto = self.image.get_size()
        self.x = random.randint(0,ventanaH-self.ancho)
        self.y = -self.alto;
    def mostrar(self, ventana):
        ventana.blit(self.image, (self.x,self.y))
    def mover(self, accel):
        self.y += 2 + accel
        self.x += math.sin(self.y*0.02) * 3
        self.x = min(max(self.x, 0), ventanaH - self.ancho)
        if self.y > ventanaV:
            self.y = -self.alto -accel
            self.x = random.randint(0,ventanaH-self.ancho)
    def choca_con(self, otro): # otro.ancho otro.alto otro.x otro.y
        xc_enemigo = self.x + self.ancho/2
        yc_enemigo = self.y + self.ancho/2
        r_enemigo = self.ancho/2
        xc_otro = otro.x + otro.ancho/2
        yc_otro = otro.y + otro.alto/2
        r_otro = otro.ancho/2
        distancia = math.sqrt( (xc_otro - xc_enemigo)**2 + (yc_otro - yc_enemigo)**2)
        distancia_bordes = distancia - (r_enemigo + r_otro)
        return distancia_bordes <= 0

class Misil:
    def __init__(self):
        self.image = pygame.image.load("imagenes/misil.png")
        self.ancho, self.alto = self.image.get_size()
        self.x = -1
        self.y = -1
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
        self.ancho, self.alto = self.imagen.get_size()
        self.x = ventanaH/2
        self.y = ventanaV - self.alto - 20
        self.velx = 0
        self.vely = 0
        self.accel = 0
        self.salud = 5
        self.misiles = [Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),
                        Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil(),Misil()]
        self.disparo_delay = 0
        self.disparando = False
    def golpear(self):
        self.salud -= 1
    def muerta(self):
        return self.salud == 0
    def mostrar(self, ventana):
        for misil in self.misiles:
            misil.mostrar(ventana)
        ventana.blit(self.imagen, (self.x, self.y))
    def mover(self):
        if self.disparando:
            self.disparo_delay -= 1
            if self.disparo_delay < 0:
                self.disparo_delay = fps / 10
                for misil in self.misiles:
                    if misil.y < 0:
                        misil.y = self.y - misil.alto
                        misil.x = self.x + self.ancho/2 - misil.ancho/2
                        break
        self.x += self.velx
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
    def mostrar(self, ventana):
        pygame.draw.rect(ventana, blanco, (self.x,self.y,self.size, self.size + self.accel))
    def mover(self, accel):
        self.accel = accel
        # self.x = (self.x + 2*self.size*.2) % ventanaH
        self.y = ((self.y + 2*self.size*.2)+self.accel) % ventanaV
        if self.x == 0 or self.y == 0:
            self.size = random.randint(1,4)

class Estrellas:
    def __init__(self, cantidad):
        self.universo = []
        for i in range(cantidad):
            self.universo.append(Estrella())
    def mostrar(self, ventana):
        for estrella in self.universo:
            estrella.mostrar(ventana)
    def mover(self, accel):
        for estrella in self.universo:
            estrella.mover(accel)


def main():
    pygame.init()
    ventana = pygame.display.set_mode((ventanaH,ventanaV))
    estrellas = Estrellas(200)
    nave = Nave()
    jugando = True
    enemigo = Enemigo()
    while jugando:
        ventana.fill(negro)
        estrellas.mostrar(ventana)
        estrellas.mover(nave.accel)
        nave.mostrar(ventana)
        nave.mover()
        enemigo.mostrar(ventana)
        enemigo.mover(nave.accel)
        if enemigo.choca_con(nave):
            enemigo.y = ventanaV
            nave.golpear()
        if nave.muerta():
            jugando = False

        for misil in nave.misiles:
            if enemigo.choca_con(misil):
                misil.y = -misil.alto
                enemigo.y = ventanaV

        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_SPACE:
                    nave.disparar(ventana)
                if event.key == pygame.K_j:
                    nave.velx -= 6
                if event.key == pygame.K_l:
                    nave.velx += 6
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
                    nave.velx = 0
                if event.key == pygame.K_l:
                    nave.velx = 0
                if event.key == pygame.K_SPACE:
                    nave.pausa()

            if event.type == pygame.QUIT:
                jugando = False
        pygame.display.flip()
        pygame.time.Clock().tick(fps)

if __name__ == '__main__':
    main()
