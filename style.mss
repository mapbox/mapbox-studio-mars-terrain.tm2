@land: darken(#B27C57 ,20);

Map {
  background-color: @land;
}

// Mars Satellite for background texture
#mapbox_mars_satellite {
  raster-scaling: lanczos;
  raster-comp-op: src;
  raster-opacity: 0.15;
  [zoom>=5] { raster-opacity: 0.12; }
  [zoom>=6] { raster-opacity: 0.09; }
  [zoom>=7] { raster-opacity: 0.06; }
  [zoom>=8] {
    raster-colorizer-default-color: #ddd;
    raster-colorizer-stops: stop(0,#ddd);
  }
}

// Hillshades
#hillshade {
  ::9[zoom<=9], ::10[zoom=10] {
    comp-op: hard-light;
    polygon-clip: false;
    image-filters-inflate: true;
    [class='shadow']    {
      polygon-fill: #012;
      polygon-comp-op: multiply;
      polygon-opacity: 0.1;
    }
    [class='highlight'] {
      polygon-fill: #ffe;
      polygon-opacity: 0.15;
      [zoom>=8] { polygon-opacity: 0.12; }
      [zoom>=8] { polygon-opacity: 0.10; }
      [zoom>=10] { polygon-opacity: 0.08; }
    }
  }
  ::10 { image-filters: agg-stack-blur(1,1); }
}

// Contour lines
#contour.line::line {
  line-color: #000;
  line-opacity: 0.14;
  line-width: 1.2;
  [index>=5][ele!=0] {
    line-opacity: 0.24;
  }
}

// Contour labels
#contour.label::label[index>=5] {
  text-name: "[ele]+' m'";
  text-face-name: 'Open Sans Regular';
  text-placement: line;
  text-size: 10;
  text-fill: #222;
  text-avoid-edges: true;
  text-halo-fill: fadeout(@land,90);
  text-halo-radius: 2;
  text-halo-rasterizer: fast;
}

// Succesful landing sites
#place::landing[zoom>=2][type="landing"] {
  ::icon {
    marker-file: url("img/maki/rocket-24.svg");
    marker-opacity: 0.8;
  }
  text-name: "[name]+' landing site'";
  text-face-name: 'Open Sans Regular';
  text-placement: point;
  text-transform: uppercase;
  text-size: 14;
  text-fill: #eee;
  text-dy: 16;
  text-halo-fill: darken(@land,15);
  text-halo-opacity: 0.7;
  text-halo-radius: 1.5;
  text-halo-rasterizer: fast;
  text-wrap-width: 70;
  [zoom>=6] { text-size: 15; }
  [zoom<=3][name="Viking 1"] {
    text-dy: -16;
  }
  [zoom<=3][name="MER Spirit"] {
    text-dx: -16;
    text-dy: 0;
  }
  [zoom<=2][name="Curiosity"] {
    text-dy: -16;
  }
}

// Surface features
#place::features[zoom>=3] {
  [name!="Olympus Rupes"]
  [type!="landing"]
  [type!="landing_failed"] {
    text-name: "[name]";
    text-face-name: 'Super Grotesk Offc Pro Medium';
    text-placement: point;
    text-size: 16;
    text-fill: #ccc;
    text-halo-fill: darken(@land,15);
    text-halo-opacity: 0.7;
    text-halo-radius: 1.5;
    text-halo-rasterizer: fast;
    text-wrap-width: 70;
    [size>=2000] {
      text-character-spacing: 2;
    }
    [zoom>=6] { text-size: 18; }
    [size<2000] {
      text-face-name: 'Super Grotesk Offc Pro Regular';
      text-size: 13;
      text-character-spacing: 1;
      [zoom>=6] { 
        text-size: 15;
        [type="crater"] {
          text-name: "[name]+' Crater'";
          text-size: 12;
          text-character-spacing: 0;
          text-halo-radius: 1;
        }
      }
    }
    [name="Phlegra Dorsa"][zoom=3] { text-dx: -1; }
  }
}
