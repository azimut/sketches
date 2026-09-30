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
        xc_enemigo = self.x + self.ancho/2
        yc_enemigo = self.y + self.ancho/2
        r_enemigo = self.ancho/2
        xc_otro = otro.x + otro.ancho/2
        yc_otro = otro.y + otro.alto/2
        r_otro = otro.ancho/2
        distancia = math.sqrt( (xc_otro - xc_enemigo)**2 + (yc_otro - yc_enemigo)**2)
        distancia_bordes = distancia - (r_enemigo + r_otro)
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
            self.respawn()
    def respawn(self):
        self.y = -self.alto
        self.x = random.randint(0,ventanaH-self.ancho)

class Borracho(Enemigo):
    def mover(self, accel):
        self.y += 2 + accel
        self.x += math.sin(self.y*0.02) * 3
        self.x = min(max(self.x, 0), ventanaH - self.ancho)
        if self.y > ventanaV:
            self.respawn()

class Firme(Enemigo):
    def mover(self, accel):
        self.y += 2 + accel
        if self.y > ventanaV:
            self.respawn()

class Misil:
    def __init__(self):
        self.image = pygame.image.load("imagenes/misil.png")
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
        self.sonido_boom = pygame.mixer.Sound("sonidos/boom.ogg")
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
    def mostrar(self, ventana):
        pygame.draw.rect(ventana, blanco, (self.x,self.y,self.size, self.size + self.accel))
    def mover(self, accel, estado):
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
    enemigo = Borracho()
    puntaje = Puntaje()
    titulo = Titulo()
    resultado = Resultado()
    estado = 0
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
            enemigo.mostrar(ventana)
            enemigo.mover(nave.accel)
            puntaje.mostrar(ventana)
            puntaje.puntuar(1)
            if enemigo.choca_con(nave):
                enemigo.y = ventanaV
                nave.golpear()
            if nave.muerta():
                estado = 2
            for misil in nave.misiles:
                if enemigo.choca_con(misil):
                    misil.y = -ventanaV
                    enemigo.respawn()
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
